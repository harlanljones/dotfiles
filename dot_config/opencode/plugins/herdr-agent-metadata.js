// User plugin: reports $model / $provider / $effort / $usage_pct sidebar
// tokens to Herdr.
//
// The herdr-installed herdr-agent-state.js owns session identity and state;
// this file deliberately lives beside it (the integration header says to add
// custom plugins beside it, not to edit it) because the bundled integration
// reports no metadata tokens. Model/provider/effort are reported on
// chat.params; usage_pct is reported when the corresponding assistant message
// is updated, using the model's actual context limit. TTL is long so the
// values outlive idle stretches.

import net from "node:net";

const SOURCE = "herdr:opencode-metadata";
const AGENT = "opencode";
const TTL_MS = 86400000;

let reportSeq = Date.now() * 1000;
let requestChain = Promise.resolve();
let activeSessionID;
let activeContextWindow;

function request(method, params) {
  const pending = requestChain.then(() => requestOnce(method, params));
  requestChain = pending.catch(() => {});
  return pending;
}

function requestOnce(method, params) {
  const paneId = process.env.HERDR_PANE_ID;
  const socketPath = process.env.HERDR_SOCKET_PATH;
  if (!paneId || !socketPath) {
    return Promise.resolve();
  }
  const socketEndpoint =
    process.platform === "win32" ? `\\\\.\\pipe\\${socketPath}` : socketPath;
  const requestId = `${SOURCE}:${Date.now()}:${Math.floor(Math.random() * 1_000_000)
    .toString()
    .padStart(6, "0")}`;
  const request = {
    id: requestId,
    method,
    params: {
      pane_id: paneId,
      source: SOURCE,
      agent: AGENT,
      seq: ++reportSeq,
      ...params,
    },
  };
  return new Promise((resolve) => {
    const client = net.createConnection(socketEndpoint, () => {
      client.write(`${JSON.stringify(request)}\n`);
    });
    const finish = () => {
      client.destroy();
      resolve();
    };
    client.setTimeout(500, finish);
    client.on("data", finish);
    client.on("error", finish);
    client.on("end", finish);
    client.on("close", resolve);
  });
}

function tokenFrom(value) {
  if (typeof value === "string" && value) return value;
  if (typeof value?.id === "string" && value.id) return value.id;
  if (typeof value?.modelID === "string" && value.modelID) return value.modelID;
  if (typeof value?.model === "string" && value.model) return value.model;
  return undefined;
}

function contextUsagePercent(info) {
  if (!info?.tokens || !activeContextWindow) return undefined;
  const tokens = info.tokens;
  const used =
    Number(tokens.total) ||
    Number(tokens.input || 0) +
      Number(tokens.output || 0) +
      Number(tokens.reasoning || 0) +
      Number(tokens.cache?.read || 0) +
      Number(tokens.cache?.write || 0);
  if (!Number.isFinite(used) || used <= 0) return undefined;
  return Math.min(Math.floor((used * 100) / activeContextWindow), 100);
}

export const HerdrAgentMetadataPlugin = async () => {
  if (
    process.env.HERDR_ENV !== "1" ||
    !process.env.HERDR_SOCKET_PATH ||
    !process.env.HERDR_PANE_ID
  ) {
    return {};
  }

  return {
    "chat.params": async (input) => {
      activeSessionID = input?.sessionID;
      activeContextWindow = Number(input?.model?.limit?.context) || undefined;
      const tokens = {};
      const modelID = tokenFrom(input?.model);
      const providerID = tokenFrom(input?.provider);
      if (modelID) tokens.model = modelID;
      if (providerID) tokens.provider = providerID;
      const effort =
        input?.effort ??
        input?.model?.effort ??
        input?.provider?.effort ??
        input?.message?.metadata?.effort;
      if (typeof effort === "string" && effort) tokens.effort = effort;
      if (Object.keys(tokens).length === 0) {
        return;
      }
      await request("pane.report_metadata", { ttl_ms: TTL_MS, tokens });
    },
    event: async ({ event }) => {
      if (event?.type !== "message.updated") return;
      const info = event.properties?.info;
      if (
        info?.role !== "assistant" ||
        !info.sessionID ||
        info.sessionID !== activeSessionID
      ) {
        return;
      }
      const usagePct = contextUsagePercent(info);
      if (usagePct === undefined) return;
      await request("pane.report_metadata", {
        ttl_ms: TTL_MS,
        tokens: { usage_pct: String(usagePct) },
      });
    },
  };
};

export default {
  id: "herdr.opencode-metadata",
  server: HerdrAgentMetadataPlugin,
  setup() {},
};
