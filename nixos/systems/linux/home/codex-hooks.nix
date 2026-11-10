{ pkgs, tmux-agent-sidebar }:
let
  tmux-agent-sidebar-root = builtins.dirOf tmux-agent-sidebar.rtp;
  codex-agent-sidebar-hook = event: {
    type = "command";
    command = "${pkgs.bashNonInteractive}/bin/bash ${tmux-agent-sidebar-root}/hook.sh codex ${event}";
    timeout = 3;
  };
in
builtins.toJSON {
  description = "Report Codex lifecycle events to tmux-agent-sidebar.";
  hooks = {
    SessionStart = [
      {
        matcher = "startup|resume";
        hooks = [ (codex-agent-sidebar-hook "session-start") ];
      }
    ];
    UserPromptSubmit = [
      {
        hooks = [ (codex-agent-sidebar-hook "user-prompt-submit") ];
      }
    ];
    PostToolUse = [
      {
        hooks = [ (codex-agent-sidebar-hook "activity-log") ];
      }
    ];
    Stop = [
      {
        hooks = [ (codex-agent-sidebar-hook "stop") ];
      }
    ];
  };
}
