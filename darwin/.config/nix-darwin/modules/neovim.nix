{ nvim, ... }: {
  # nixvim ビルド済みの Neovim を全ホストに導入 (Mac / リモートで同一環境)
  environment.systemPackages = [ nvim ];
  environment.variables.EDITOR = "nvim";
}
