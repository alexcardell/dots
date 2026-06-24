#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
HELPER="${ROOT}/copilot-sync-metals-mcp.sh"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

pass() {
  printf 'PASS: %s\n' "$1"
}

assert_json() {
  local file="$1"
  local filter="$2"
  local expected="$3"
  local actual

  actual="$(jq -r "$filter" "$file")"
  [[ "$actual" == "$expected" ]] || fail "expected ${filter} in ${file} to be ${expected}, got ${actual}"
}

init_repo() {
  local repo_root="$1"
  git init -q "$repo_root"
}

tmpdir="${ROOT}/.copilot-sync-test.$$"
rm -rf "$tmpdir"
mkdir -p "$tmpdir"
trap 'rm -rf "$tmpdir"' EXIT

fake_home="${tmpdir}/fake-home"
mkdir -p "$fake_home"
global_config="${fake_home}/.copilot/mcp-config.json"

project_one="${tmpdir}/deliverables-api"
mkdir -p "${project_one}/.metals" "${project_one}/apps/api/src"
init_repo "$project_one"
cat > "${project_one}/.metals/mcp.json" <<JSON
{
  "servers": {
    "${project_one}": {
      "url": "http://localhost:55440/mcp"
    }
  }
}
JSON

HOME="$fake_home" bash "$HELPER" "${project_one}/apps/api/src"
assert_json "$global_config" '.mcpServers["metals-deliverables-api"].type' 'http'
assert_json "$global_config" '.mcpServers["metals-deliverables-api"].url' 'http://localhost:55440/mcp'
assert_json "$global_config" '.mcpServers["metals-deliverables-api"].tools[0]' '*'
[[ ! -e "${project_one}/.copilot/mcp-config.json" ]] || fail 'expected no project-local Copilot config to be created'
pass 'writes the repo-scoped Metals entry to the global Copilot config'

project_two="${tmpdir}/payments-api"
mkdir -p "${project_two}/.metals" "${project_two}/services/payments/src"
init_repo "$project_two"
cat > "${project_two}/.metals/mcp.json" <<JSON
{
  "servers": {
    "${project_two}": {
      "url": "http://localhost:61234/mcp"
    }
  }
}
JSON
mkdir -p "${fake_home}/.copilot"
cat > "$global_config" <<'JSON'
{
  "mcpServers": {
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp",
      "tools": ["*"]
    }
  }
}
JSON

HOME="$fake_home" bash "$HELPER" "${project_two}/services/payments/src"
assert_json "$global_config" '.mcpServers.context7.url' 'https://mcp.context7.com/mcp'
assert_json "$global_config" '.mcpServers["metals-payments-api"].url' 'http://localhost:61234/mcp'
pass 'merges the repo-specific Metals entry into the global config without touching unrelated MCP servers'

project_three="${tmpdir}/inventory-api"
mkdir -p "${project_three}/packages/inventory/src"
init_repo "$project_three"
before_config="$(cat "$global_config")"

HOME="$fake_home" bash "$HELPER" "${project_three}/packages/inventory/src"
after_config="$(cat "$global_config")"
[[ "$before_config" == "$after_config" ]] || fail 'expected no change to the global config when no ancestor .metals/mcp.json exists before the Git root'
pass 'stops at the Git repo root and leaves the global config untouched when no ancestor Metals config exists'

project_four="${tmpdir}/orders-api"
mkdir -p "${project_four}/.metals" "${project_four}/modules/orders/src"
init_repo "$project_four"
cat > "${project_four}/.metals/mcp.json" <<JSON
{
  "servers": {
    "${project_four}": {
      "url": "http://localhost:63333/mcp"
    }
  }
}
JSON
printf '{broken json\n' > "$global_config"

stderr_file="${tmpdir}/orders.stderr"
HOME="$fake_home" bash "$HELPER" "${project_four}/modules/orders/src" 2>"${stderr_file}"
grep -q 'malformed' "${stderr_file}" || fail 'expected malformed Copilot config warning'
grep -q '{broken json' "$global_config" || fail 'expected malformed global Copilot config to stay unchanged'
pass 'warns and leaves malformed global Copilot config untouched'

project_five="${tmpdir}/customers-api"
mkdir -p "${project_five}/.metals" "${project_five}/apps/customers/src"
init_repo "$project_five"
printf '{broken\n' > "${project_five}/.metals/mcp.json"
cat > "$global_config" <<'JSON'
{
  "mcpServers": {
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp",
      "tools": ["*"]
    }
  }
}
JSON

stderr_file="${tmpdir}/customers.stderr"
HOME="$fake_home" bash "$HELPER" "${project_five}/apps/customers/src" 2>"${stderr_file}"
grep -q 'malformed or has no server URL' "${stderr_file}" || fail 'expected malformed Metals config warning'
assert_json "$global_config" '.mcpServers.context7.url' 'https://mcp.context7.com/mcp'
pass 'warns and leaves the global config untouched when .metals/mcp.json is malformed'

project_six="${tmpdir}/catalog-api"
mkdir -p "${project_six}/.metals" "${project_six}/src/catalog/service"
init_repo "$project_six"
cat > "${project_six}/.metals/mcp.json" <<JSON
{
  "servers": {
    "${project_six}": {
      "url": "http://localhost:64444/mcp"
    }
  }
}
JSON

HOME="$fake_home" bash "$HELPER" "${project_six}/src/catalog/service"
first_config="$(cat "$global_config")"
HOME="$fake_home" bash "$HELPER" "${project_six}/src/catalog/service"
second_config="$(cat "$global_config")"
[[ "$first_config" == "$second_config" ]] || fail 'expected repeated runs to leave the global Copilot config unchanged'
pass 'is idempotent when run twice on the same project'

project_seven="${tmpdir}/outside-git"
mkdir -p "${project_seven}/nested/path"
before_config="$(cat "$global_config")"

HOME="$fake_home" GIT_CEILING_DIRECTORIES="$tmpdir" bash "$HELPER" "${project_seven}/nested/path"
after_config="$(cat "$global_config")"
[[ "$before_config" == "$after_config" ]] || fail 'expected no change to the global config when the starting directory is outside a Git repository'
pass 'no-ops when the starting directory is outside a Git repository'

printf 'All helper tests passed.\n'
