{
  bashNonInteractive,
  lib,
  fetchFromGitHub,
  tmuxPlugins,
}:

tmuxPlugins.mkTmuxPlugin {
  pluginName = "tmux-agent-status";
  version = "unstable-2026-07-31";
  rtpFilePath = "tmux-agent-status.tmux";

  src = fetchFromGitHub {
    owner = "samleeney";
    repo = "tmux-agent-status";
    rev = "a323f10eedabc499fc1c8d4e1c73a564c6e3ae70";
    hash = "sha256-JMZt88rZkvLYRXZriWDeY1wZtqD8t/wawcIG62nm9X4=";
  };

  postPatch = ''
    sed -i '/daemon-monitor\.sh/s/run-shell /run-shell -b /' tmux-agent-status.tmux

    substituteInPlace tmux-agent-status.tmux \
      --replace-fail \
        '"$CURRENT_DIR/scripts/sidebar-collector.sh" &' \
        '"$CURRENT_DIR/scripts/sidebar-collector.sh" >/dev/null 2>&1 &'

    substituteInPlace scripts/daemon-monitor.sh \
      --replace-fail \
        'echo $$ > "$MONITOR_PID_FILE"' \
        'echo "$BASHPID" > "$MONITOR_PID_FILE"' \
      --replace-fail \
        'while tmux list-sessions >/dev/null 2>&1; do' \
        'while tmux list-sessions -F '\'''#{session_id}'\''' 2>/dev/null | grep -q .; do' \
      --replace-fail ') &' ') >/dev/null 2>&1 &'

    substituteInPlace scripts/sidebar-collector.sh \
      --replace-fail \
        'tmux list-sessions >/dev/null 2>&1 || exit 0' \
        'tmux list-sessions -F '\'''#{session_id}'\''' 2>/dev/null | grep -q . || exit 0'
  '';

  postInstall = ''
    find "$target" -type f -exec sed -i \
      '1s|^#!/usr/bin/env bash$|#!${lib.getExe bashNonInteractive}|' {} +
  '';

  meta = {
    description = "Sidebar-first AI agent session manager for tmux";
    homepage = "https://github.com/samleeney/tmux-agent-status";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
