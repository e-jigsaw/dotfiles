{ pkgs, ... }:
{
  # grammar は Nix 側でビルド済みを同梱 (実行時コンパイル排除)
  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      typescript
      tsx
      javascript
      nix
      lua
      json
      html
      css
      markdown
      markdown_inline
      bash
    ];
  };
}
