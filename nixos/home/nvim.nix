{ pkgs, ... }:
let
  pinnedVimPlugins = {
    mcphub-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "mcphub.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "ravitemer";
        repo = "mcphub.nvim";
        rev = "5e39057c4405bc7b83ef9fd38a37d18c9330e403";
        hash = "sha256-qmvkQTKJ4Qt2SL+d9pGtmLAPVmCYAFnflf0e0BX1wYM=";
      };
      dependencies = with pkgs.unstable.vimPlugins; [
        plenary-nvim
        lualine-nvim
      ];
      nvimSkipModules = [
        "bundled_build"
      ];
    };
    codecompanion-spinner-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "codecompanion-spinner.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "franco-ruggeri";
        repo = "codecompanion-spinner.nvim";
        rev = "c1fa2a84ea1aed687aaed60df65e347c280f4f22";
        hash = "sha256-+lalwWE02YlLlU5zSqBotI5YstDuXtF8k0e6b7lxnhU=";
      };
    };

  };
  mcp-hub = pkgs.buildNpmPackage {
    pname = "mcp-hub";
    version = "4.2.1"; # replace with version
    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/mcp-hub/-/mcp-hub-4.2.1.tgz";
      sha256 = "sha256-a2UI2hPJbnJglGbX7YCex2ON8+m14hoc3ApZu21PuCs=";
    };
    postPatch = ''
      cp ${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/ravitemer/mcp-hub/9c7670a4c341ed3cf738a6242c0fde1cea40bccf/package-lock.json";
          sha256 = "sha256-721x+/2GeQfGKKVcWMKwIdW+HJoo55EvR1HYD8pIi0o=";
        }
      } package-lock.json
    '';
    npmDepsHash = "sha256-nyenuxsKRAL0PU/UPSJsz8ftHIF+LBTGdygTqxti38g=";
    dontNpmBuild = true;
  };
in
{
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    package = pkgs.unstable.neovim-unwrapped;

    extraPackages = with pkgs.unstable; [
      mcp-hub
      docker-compose-language-service
      dockerfile-language-server-nodejs
      ltex-ls
      lua-language-server
      metals
      nixd
      terraform-ls
      typescript-language-server
      yaml-language-server
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
        pinned = pinnedVimPlugins;
      in
      [
        pinned.codecompanion-spinner-nvim
        pinned.mcphub-nvim
        plug.Navigator-nvim
        plug.avante-nvim
        plug.base16-nvim
        plug.blink-cmp
        plug.codecompanion-history-nvim
        plug.codecompanion-nvim
        plug.copilot-vim
        plug.diffview-nvim
        plug.edgy-nvim
        plug.fidget-nvim
        plug.gitsigns-nvim
        plug.hardtime-nvim
        plug.img-clip-nvim
        plug.indent-blankline-nvim
        plug.lsp-progress-nvim
        plug.lspkind-nvim
        plug.lualine-nvim
        plug.luasnip
        plug.marks-nvim
        plug.neogit
        plug.nui-nvim
        plug.nvim-autopairs
        plug.nvim-dap
        plug.nvim-dap-ui
        plug.nvim-dap-virtual-text
        plug.nvim-lint
        plug.nvim-lspconfig
        plug.nvim-metals
        plug.nvim-nio
        plug.nvim-surround
        plug.nvim-treesitter-textobjects # TODO add more textobjects
        plug.nvim-treesitter.withAllGrammars
        plug.nvim-ts-autotag
        plug.nvim-web-devicons
        plug.oil-nvim
        plug.other-nvim
        plug.outline-nvim
        plug.plenary-nvim
        plug.render-markdown-nvim
        plug.telescope-dap-nvim
        plug.telescope-nvim
        plug.telescope-ui-select-nvim
        plug.tint-nvim
        plug.undotree
        plug.vectorcode-nvim
        plug.vim-dadbod
        plug.vim-dadbod-completion
        plug.vim-dadbod-ui
        plug.vim-fugitive
        plug.vim-pencil
        plug.vim-rhubarb
      ];
  };
}
