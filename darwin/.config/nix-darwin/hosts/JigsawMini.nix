{ ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.jigsaw = {
    name = "jigsaw";
    home = "/Users/jigsaw";
  };
  system.primaryUser = "jigsaw";
}
