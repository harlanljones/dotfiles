# Codebase Memory Promotion Questions

## Q-codebase-memory-schema

Should a promoted guide pin a fixed tool count and edge taxonomy?

Recommendation: no. Treat live tool advertisement and `get_graph_schema` as
authoritative, and label any static names as examples. Availability can vary by
server generation and project, so a fixed exhaustive list becomes a false
contract.

## Q-codebase-memory-efficiency

Should the numeric token-efficiency comparison be retained?

Recommendation: remove it unless a reproducible benchmark, workload and
measurement date are supplied. The frozen candidate provides no evidence for the
quoted numbers; a plausible efficiency benefit is not a measured result.
