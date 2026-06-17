{ pkgs, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./lsp.nix
    ./treesitter.nix
    ./completion.nix
    ./telescope.nix
    ./ui.nix
  ];

  # `vi` / `vim` も この Neovim を起動する (ssh 先でも一貫した起動コマンド)
  viAlias = true;
  vimAlias = true;

  # システムクリップボード連携 (ローカルでは pbcopy/xclip 等)
  clipboard.register = "unnamedplus";

  # OSC52: ssh セッション中のみ yank をローカルクリップボードへ飛ばす。
  # ローカル (非 ssh) では nixvim 既定のプロバイダ (Mac は pbcopy) のまま。
  extraConfigLua = ''
    if vim.env.SSH_TTY ~= nil then
      local osc52 = require("vim.ui.clipboard.osc52")
      vim.g.clipboard = {
        name = "OSC 52",
        copy = {
          ["+"] = osc52.copy("+"),
          ["*"] = osc52.copy("*"),
        },
        paste = {
          ["+"] = osc52.paste("+"),
          ["*"] = osc52.paste("*"),
        },
      }
    end
  '';

  # 設定がシェルアウトする CLI ツール (telescope live_grep が ripgrep/fd 必須)
  extraPackages = with pkgs; [ ripgrep fd ];

  colorschemes.catppuccin = {
    enable = true;
    settings.flavour = "mocha";
  };
}
