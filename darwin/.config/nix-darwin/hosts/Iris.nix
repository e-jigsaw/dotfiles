{ ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users."takaya.kobayashi" = {
    name = "takaya.kobayashi";
    home = "/Users/takaya.kobayashi";
  };
  system.primaryUser = "takaya.kobayashi";

  homebrew.casks = [
    "gcloud-cli"
    "karabiner-elements"
    "orbstack"
  ];
}
