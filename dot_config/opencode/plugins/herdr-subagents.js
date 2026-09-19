// Companion to Herdr's opencode integration: surfaces in-session subagents
// (child sessions) as display-only pane metadata.
//
// The bundled plugin deliberately filters child sessions so they can never
// replace the pane's root session. The price is invisibility, so this
// sidecar keeps the same roster file as herdr-subagents(1) and mirrors it
// as metadata tokens (subagents=N, subagent_names=a,b). It never reports
// sessions or lifecycle state: root authority stays exactly as without it.
//
// Child start: any event whose properties.info carries {id, parentID}.
// Child end: session.deleted for a rostered id. Anything else is ignored.
// Roster: ~/.local/state/herdr/subagents.json, mode 0600, stale entries
// (>6h) pruned on every update.
import net from "node:net";
import { promises as fs } from "node:fs";
import os from "node:os";
import path from "node:path";

const SOURCE = "custom:opencode-subagents";
const AGENT = "opencode";
const TTL_MS = 1200000;
const STALE_SEC = 6 * 3600;
const MAX_SUBS = 8;
const ROSTER = path.join(os.homedir(), ".local", "state", "herdr", "subagents.json");
const SOCKET = process.env.HERDR_SOCKET_PATH || "";
const PANE = process.env.HERDR_PANE_ID || "";

function socketSend(payload) {
  return new Promise((resolve) => {
    if (!SOCKET) return resolve();
    let client;
    try {
      client = net.createConnection(SOCKET);
    } catch {
      return resolve();
    }
    client.setTimeout(2000);
    client.on("error", () => resolve());
    client.on("timeout", () => { try { client.destroy(); } catch {} resolve(); });
    client.write(JSON.stringify(payload) + "\n", () => {
      client.end(() => resolve());
    });
  });
}

async function readRoster() {
  try {
    const raw = await fs.readFile(ROSTER, "utf8");
    const parsed = JSON.parse(raw);
    return parsed && typeof parsed === "object" ? parsed : {};
  } catch {
    return {};
  }
}

async function publish() {
  const roster = await readRoster();
  const mine = roster[PANE] && typeof roster[PANE] === "object" ? roster[PANE] : {};
  const now = Date.now() / 1000;
  for (const sid of Object.keys(mine)) {
    const e = mine[sid];
    if (!e || typeof e !== "object" || now - Number(e.started || 0) > STALE_SEC) delete mine[sid];
  }
  if (Object.keys(mine).length > 0) roster[PANE] = mine;
  else delete roster[PANE];
  try {
    await fs.mkdir(path.dirname(ROSTER), { recursive: true });
    const tmp = `${ROSTER}.tmp.${process.pid}`;
    await fs.writeFile(tmp, JSON.stringify(roster), { mode: 0o600 });
    await fs.rename(tmp, ROSTER);
  } catch {}
  const ids = Object.keys(mine).sort(
    (a, b) => Number(mine[b].started || 0) - Number(mine[a].started || 0));
  const params = { pane_id: PANE, source: SOURCE, ttl_ms: TTL_MS };
  if (ids.length > 0) {
    const names = ids.map((id) => String(mine[id].name || "subagent")).join(",").slice(0, 120);
    params.tokens = { subagents: String(ids.length), subagent_names: names || String(ids.length) };
  } else {
    params.tokens = { subagents: null, subagent_names: null };
  }
  await socketSend({ id: `${SOURCE}:${Date.now()}`, method: "pane.report_metadata", params });
}

async function trackChild(id, name) {
  if (!PANE || !id) return;
  const roster = await readRoster();
  const mine = roster[PANE] && typeof roster[PANE] === "object" ? roster[PANE] : {};
  mine[id] = { agent: AGENT, name: String(name || "subagent").slice(0, 24), started: Date.now() / 1000 };
  while (Object.keys(mine).length > MAX_SUBS) {
    let oldest = null;
    for (const sid of Object.keys(mine)) {
      if (oldest === null || Number(mine[sid].started || 0) < Number(mine[oldest].started || 0)) oldest = sid;
    }
    if (oldest === null) break;
    delete mine[oldest];
  }
  roster[PANE] = mine;
  try {
    await fs.mkdir(path.dirname(ROSTER), { recursive: true });
    const tmp = `${ROSTER}.tmp.${process.pid}`;
    await fs.writeFile(tmp, JSON.stringify(roster), { mode: 0o600 });
    await fs.rename(tmp, ROSTER);
  } catch {}
  await publish();
}

async function untrackChild(id) {
  if (!PANE || !id) return;
  const roster = await readRoster();
  const mine = roster[PANE] && typeof roster[PANE] === "object" ? roster[PANE] : {};
  if (!(id in mine)) return;
  delete mine[id];
  if (Object.keys(mine).length > 0) roster[PANE] = mine;
  else delete roster[PANE];
  try {
    await fs.mkdir(path.dirname(ROSTER), { recursive: true });
    const tmp = `${ROSTER}.tmp.${process.pid}`;
    await fs.writeFile(tmp, JSON.stringify(roster), { mode: 0o600 });
    await fs.rename(tmp, ROSTER);
  } catch {}
  await publish();
}

function childInfo(event) {
  const properties = event?.properties ?? {};
  const info = properties.info;
  if (info && typeof info.id === "string" && info.id && info.parentID) {
    return { id: info.id, name: info.title || info.name || info.taskType };
  }
  return null;
}

export const HerdrSubagentsPlugin = {
  event: async ({ event }) => {
    if (!PANE || !event) return;
    const type = event?.type;
    const properties = event?.properties ?? {};
    const child = childInfo(event);
    if (child) {
      await trackChild(child.id, child.name);
      return;
    }
    if (type === "session.deleted") {
      const sid = typeof properties.sessionID === "string" && properties.sessionID
        ? properties.sessionID
        : (typeof properties.sessionId === "string" ? properties.sessionId : undefined);
      if (sid) await untrackChild(sid);
    }
  },
};

export default {
  id: "herdr.opencode-subagents",
  server: HerdrSubagentsPlugin,
  setup() {},
};
