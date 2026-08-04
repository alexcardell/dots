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
