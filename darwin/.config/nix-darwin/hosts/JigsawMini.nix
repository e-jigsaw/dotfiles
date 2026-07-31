{ pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.jigsaw = {
    name = "jigsaw";
    home = "/Users/jigsaw";
  };
  system.primaryUser = "jigsaw";

  environment.systemPackages = [
    # nixpkgs の elektroid は Linux 専用なので自前定義を使う
    (pkgs.callPackage ../packages/elektroid.nix { })
  ];
}
