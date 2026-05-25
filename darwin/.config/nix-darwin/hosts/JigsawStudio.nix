{ pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.jigsaw = {
    name = "jigsaw";
    home = "/Users/jigsaw";
  };
  system.primaryUser = "jigsaw";

  environment.systemPackages = with pkgs; [
    ghq
    nomad
    vhs
    yt-dlp
  ];

  homebrew.casks = [
    "db-browser-for-sqlite"
    "google-chrome"
    "openscad"
    "visual-studio-code"
  ];
}
