{ pkgs, ... }:
let
  vimPluginsGithub = {
    # nvim-metals = pkgs.vimUtils.buildVimPlugin {
    #   name = "nvim-metals";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "scalameta";
    #     repo = "nvim-metals";
    #     rev = "1b87e6bfa4174b5fbaee9ca7ec79d8eae8df7f18";
    #     hash = "sha256-VQOolBCVYZ1T71REjgD7X/+txd1awmdGgW154hc30Y8=";
    #   };
    # };
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
      ltex-ls
      lua-language-server
      metals
      nixd
      nodePackages.typescript-language-server
      terraform-ls
      # wakatime
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
        pinned = vimPluginsGithub;
      in [
        # plug.cmp-buffer
        # plug.cmp-dap
        # plug.cmp-git
        # plug.cmp-nvim-lsp
        # plug.cmp-nvim-lsp-signature-help
        # plug.cmp-nvim-lua
        # plug.cmp-path
        # plug.cmp_luasnip
        # plug.markdown-preview-nvim
        # plug.nvim-cmp
        # plug.nvim-lint
        # plug.telescope-fzf-writer-nvim
        # plug.telescope-symbols-nvim
        # plug.twilight-nvim
        # plug.vim-commentary
        # plug.vim-fugitive
        # plug.vim-illuminate
        # plug.vim-nix
        # plug.vim-repeat
        # plug.vim-rhubarb
        # plug.vim-surround
        # plug.vim-wakatime
        # plug.zen-mode-nvim
        # plug.zk-nvim
        plug.Navigator-nvim
        plug.avante-nvim
        plug.base16-nvim
        plug.blink-cmp
        plug.codecompanion-nvim
        plug.diffview-nvim
        plug.edgy-nvim
        plug.fidget-nvim
        plug.gitsigns-nvim
        plug.hardtime-nvim
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
        plug.vim-dadbod
        plug.vim-dadbod-completion
        plug.vim-dadbod-ui
        plug.vim-fugitive
        plug.vim-pencil
        plug.vim-rhubarb
      ];
  };
}
