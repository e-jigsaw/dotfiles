{ pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users."takaya.kobayashi" = {
    name = "takaya.kobayashi";
    home = "/Users/takaya.kobayashi";
  };
  system.primaryUser = "takaya.kobayashi";

  environment.systemPackages = [
    (pkgs.callPackage ../packages/tau.nix { })
  ];

  homebrew.casks = [
    "gcloud-cli"
    "karabiner-elements"
    "orbstack"
  ];
}
