{
  bashNonInteractive,
  fetchFromGitHub,
  lib,
  rustPlatform,
  tmuxPlugins,
}:

let
  version = "unstable-2026-09-05";

  src = fetchFromGitHub {
    owner = "hiroppy";
    repo = "tmux-agent-sidebar";
    rev = "fb118182f45da26d1c8e6e2e394711ef01aaf71b";
    hash = "sha256-UXN+CjJFnftBNLsdMad22AHfn88l2sVJ4V+4NbCgR6s=";
  };

  tmux-agent-sidebar = rustPlatform.buildRustPackage {
    pname = "tmux-agent-sidebar";
    inherit version src;

    cargoHash = "sha256-4029Z4jWIlGinGrofrDwnLKXaWWWdmUR+2/l04slCRA=";

    # These tests inspect the source checkout's .git directory, which is not
    # included in fetchFromGitHub's archive. Keep the rest of the test suite.
    checkFlags = [
      "--skip=group::tests::resolve_git_info_for_real_repo"
      "--skip=group::tests::worktree_and_main_share_same_repo_root"
    ];

    meta = {
      description = "Tmux sidebar for monitoring AI coding agents";
      homepage = "https://github.com/hiroppy/tmux-agent-sidebar";
      license = lib.licenses.mit;
      mainProgram = "tmux-agent-sidebar";
      platforms = lib.platforms.unix;
    };
  };
in
tmuxPlugins.mkTmuxPlugin {
  pluginName = "tmux-agent-sidebar";
  inherit version src;
  rtpFilePath = "tmux-agent-sidebar.tmux";

  postInstall = ''
    mkdir -p "$target/bin"
    cp ${tmux-agent-sidebar}/bin/tmux-agent-sidebar "$target/bin/"

    substituteInPlace \
      "$target/tmux-agent-sidebar.tmux" \
      "$target/hook.sh" \
      --replace-fail \
        '#!/usr/bin/env bash' \
        '#!${lib.getExe bashNonInteractive}'
  '';

  meta = {
    description = "Tmux sidebar for monitoring AI coding agents";
    homepage = "https://github.com/hiroppy/tmux-agent-sidebar";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
