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
copilot_dir="${HOME}/.copilot"
copilot_file="${copilot_dir}/mcp-config.json"
repo_name="$(basename "$project_root")"
server_name="metals-${repo_name}"

if ! url="$(jq -er '.servers | to_entries[0].value.url' "$metals_file" 2>/dev/null)"; then
  warn "skipping Metals MCP sync: ${metals_file} is malformed or has no server URL"
  exit 0
fi

mkdir -p "$copilot_dir"

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

tmp_file="${copilot_dir}/mcp-config.json.$$"
rm -f "$tmp_file"
trap 'rm -f "$tmp_file"' EXIT

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
  "$copilot_file" > "$tmp_file"

mv "$tmp_file" "$copilot_file"
