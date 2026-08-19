{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    sketchybar
    sketchybar-app-font
  ];

  launchd.agents.lspmux = {
    enable = true;
    config = {
      Label = "org.alexcard.lspmux";
      ProgramArguments = [
        "${pkgs.lspmux}/bin/lspmux"
        "server"
      ];
      EnvironmentVariables.HOME = config.home.homeDirectory;
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Background";
    };
  };

  home.file."Library/Application Support/lspmux/config.toml".text = ''
    listen = ["127.0.0.1", 27631]
    connect = ["127.0.0.1", 27631]
  '';

  home.file.".local/bin/copilot-sync-metals-mcp.sh" = {
    source = ./scripts/copilot-sync-metals-mcp.sh;
    executable = true;
  };

}
