{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sketchybar
    sketchybar-app-font
  ];

  home.file.".local/bin/copilot-sync-metals-mcp.sh" = {
    source = ./scripts/copilot-sync-metals-mcp.sh;
    executable = true;
  };

}
