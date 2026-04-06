{ ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew.casks = [
    "orbstack"
  ];
}
