{ pkgs, ... }:
{
  # LSP サーバは Nix 側で宣言して持ち込む (mason は使わない / リモートで実行時 DL が走らない)
  plugins.lsp = {
    enable = true;
    servers = {
      # TypeScript / React
      vtsls = {
        enable = true;
        package = pkgs.vtsls;
      };
      # Bun 系のフォーマット・lint
      biome = {
        enable = true;
        package = pkgs.biome;
      };
      # 設定自身 (Lua) の補完用
      lua_ls = {
        enable = true;
        package = pkgs.lua-language-server;
      };
      # Nix ファイル編集用
      nil_ls = {
        enable = true;
        package = pkgs.nil;
      };
      # Tailwind v4
      tailwindcss = {
        enable = true;
        package = pkgs.tailwindcss-language-server;
      };
    };
  };
}
