{ pkgs, ... }:

let
  readAndPadFile = file: "\n${builtins.readFile file}\n";
in
{
  programs.neovim =
    let
      lsps = with pkgs; [
        clang-tools
        coursier
        docker-compose-language-service
        dockerfile-language-server-nodejs
        jdt-language-server
        lemminx
        lombok
        lua-language-server
        metals
        nixd
        nixfmt-rfc-style
        rust-analyzer
      ];
      linters = with pkgs; [
        checkstyle
        yamllint
        sqlfluff
      ];
      formatters = with pkgs; [
        black
        cmake-format
        fourmolu
        google-java-format
        isort
        rustfmt
        scalafmt
        shfmt
        stylish-haskell
        stylua
        xmlformat
      ];
    in
    {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = builtins.concatLists [
        lsps
        linters
        formatters
      ];
      extraLuaConfig = (
        builtins.concatStringsSep "\n" [
          (readAndPadFile ./../config/nvim/options.lua)
          (readAndPadFile ./../config/nvim/mappings.lua)
          (readAndPadFile ./../config/nvim/misc.lua)
          (readAndPadFile ./../config/nvim/plugins/blink.lua)
          (readAndPadFile ./../config/nvim/plugins/bufferline.lua)
          (readAndPadFile ./../config/nvim/plugins/conform.lua)
          (readAndPadFile ./../config/nvim/plugins/gruvbox.lua)
          (readAndPadFile ./../config/nvim/plugins/highlight-colors.lua)
          (readAndPadFile ./../config/nvim/plugins/lualine.lua)
          (readAndPadFile ./../config/nvim/plugins/noice.lua)
          (readAndPadFile ./../config/nvim/plugins/lint.lua)
          (readAndPadFile ./../config/nvim/plugins/rendermarkdown.lua)
          (readAndPadFile ./../config/nvim/plugins/snacks.lua)
          (readAndPadFile ./../config/nvim/plugins/treesitter.lua)
          (readAndPadFile ./../config/nvim/plugins/whichkey.lua)
          (builtins.replaceStrings [ "{{{lombok}}}" ] [ "${pkgs.lombok}" ]
            (readAndPadFile ./../config/nvim/lsp.lua)
          )
        ]
      );
      plugins = with pkgs.vimPlugins; [
        blink-cmp
        bufferline-nvim
        conform-nvim
        flash-nvim
        friendly-snippets
        grug-far-nvim
        gruvbox-nvim
        guess-indent-nvim
        lualine-nvim
        noice-nvim
        nvim-lint
        nvim-highlight-colors
        nvim-jdtls
        nvim-metals
        nvim-surround
        nvim-web-devicons
        rainbow-delimiters-nvim
        render-markdown-nvim
        snacks-nvim
        todo-comments-nvim
        vim-suda
        which-key-nvim
        (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-bash
          p.tree-sitter-c
          p.tree-sitter-cmake
          p.tree-sitter-cpp
          p.tree-sitter-css
          p.tree-sitter-go
          p.tree-sitter-haskell
          p.tree-sitter-html
          p.tree-sitter-java
          p.tree-sitter-json
          p.tree-sitter-lua
          p.tree-sitter-make
          p.tree-sitter-markdown
          p.tree-sitter-markdown_inline
          p.tree-sitter-nix
          p.tree-sitter-ini
          p.tree-sitter-python
          p.tree-sitter-rust
          p.tree-sitter-scala
          p.tree-sitter-scss
          p.tree-sitter-sql
          p.tree-sitter-toml
          p.tree-sitter-typescript
          p.tree-sitter-vim
          p.tree-sitter-vimdoc
          p.tree-sitter-xml
          p.tree-sitter-yaml
        ]))
      ];
    };
}
