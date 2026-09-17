'use strict';

// Radar render hook: strip "user@host:" from pane titles when the host is this
// machine, keep it when the title names a remote host (an ssh session inside
// the pane) — there the host is information, locally it is noise.

const os = require('node:os');

const local = new Set(
  [os.hostname(), os.hostname().split('.')[0], 'localhost', '127.0.0.1'].filter(Boolean).map((h) => h.toLowerCase()),
);

const PREFIX = /^([^@\s/]+)@([^:\s]+):/;

function title(text) {
  if (typeof text !== 'string') return text;
  const match = text.match(PREFIX);
  if (!match) return text;
  if (!local.has(match[2].toLowerCase())) return text;
  const rest = text.slice(match[0].length);
  return rest.trim() || text;
}

module.exports = { title };
