#!/usr/bin/env bash
set -euo pipefail

warn() {
  printf 'copilot-sync-metals-mcp: %s\n' "$1" >&2
}

start_dir="${1:-$PWD}"

if ! candidate_dir="$(cd -- "$start_dir" 2>/dev/null && pwd -P)"; then
  exit 0
fi

if ! git_root="$(git -C "$candidate_dir" rev-parse --show-toplevel 2>/dev/null)"; then
  exit 0
fi

project_root=""
while :; do
  if [[ -f "${candidate_dir}/.metals/mcp.json" ]]; then
    project_root="$candidate_dir"
    break
  fi

  if [[ "$candidate_dir" == "$git_root" ]]; then
    exit 0
  fi

  parent_dir="$(dirname "$candidate_dir")"
  if [[ "$parent_dir" == "$candidate_dir" ]]; then
    exit 0
  fi
  candidate_dir="$parent_dir"
done

metals_file="${project_root}/.metals/mcp.json"
copilot_file="${project_root}/.mcp.json"
lsp_file="${project_root}/.github/lsp.json"
repo_name="$(basename "$project_root")"
server_name="metals-$(printf '%s' "$repo_name" | LC_ALL=C tr -c 'A-Za-z0-9_-' '-')"
exclude_file="$(git -C "$project_root" rev-parse --path-format=absolute --git-path info/exclude)"

if ! url="$(jq -er '.servers | to_entries[0].value.url' "$metals_file" 2>/dev/null)"; then
  warn "skipping Metals MCP sync: ${metals_file} is malformed or has no server URL"
  exit 0
fi

mkdir -p "$(dirname "$exclude_file")"
for local_config in '.mcp.json' '.github/lsp.json'; do
  if ! grep -Fqx "$local_config" "$exclude_file" 2>/dev/null; then
    printf '%s\n' "$local_config" >> "$exclude_file"
  fi
done

printf 'copilot-sync-metals-mcp: detected %s; syncing to %s\n' "$metals_file" "$copilot_file"

if [[ -f "$copilot_file" ]]; then
  if ! jq empty "$copilot_file" >/dev/null 2>&1; then
    warn "skipping Copilot MCP sync: malformed ${copilot_file}"
    exit 0
  fi
else
  cat > "$copilot_file" <<'JSON'
{
  "mcpServers": {}
}
JSON
fi

mcp_tmp_file="${copilot_file}.$$"
lsp_tmp_file="${lsp_file}.$$"
rm -f "$mcp_tmp_file" "$lsp_tmp_file"
trap 'rm -f "$mcp_tmp_file" "$lsp_tmp_file"' EXIT

jq \
  --arg name "$server_name" \
  --arg url "$url" \
  '
  .mcpServers = (.mcpServers // {}) |
  .mcpServers[$name] = {
    type: "http",
    url: $url,
    tools: ["*"]
  }
  ' \
  "$copilot_file" > "$mcp_tmp_file"

mv "$mcp_tmp_file" "$copilot_file"

if ! lspmux_command="$(command -v lspmux)"; then
  warn "skipping Copilot LSP sync: lspmux is not available"
  exit 0
fi

if ! metals_command="$(command -v metals)"; then
  warn "skipping Copilot LSP sync: metals is not available"
  exit 0
fi

mkdir -p "$(dirname "$lsp_file")"
if [[ -f "$lsp_file" ]]; then
  if ! jq empty "$lsp_file" >/dev/null 2>&1; then
    warn "skipping Copilot LSP sync: malformed ${lsp_file}"
    exit 0
  fi
else
  cat > "$lsp_file" <<'JSON'
{
  "lspServers": {}
}
JSON
fi

printf 'copilot-sync-metals-mcp: syncing Metals LSP through lspmux to %s\n' "$lsp_file"

jq \
  --arg name "$server_name" \
  --arg lspmux "$lspmux_command" \
  --arg metals "$metals_command" \
  '
  .lspServers = (.lspServers // {}) |
  .lspServers[$name] = {
    command: $lspmux,
    args: ["client", "--server-path", $metals],
    fileExtensions: {
      ".scala": "scala",
      ".sc": "scala",
      ".sbt": "scala",
      ".java": "java"
    },
    initializationTimeoutMs: 300000
  }
  ' \
  "$lsp_file" > "$lsp_tmp_file"

mv "$lsp_tmp_file" "$lsp_file"
