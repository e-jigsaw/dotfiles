{ pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = with pkgs; [
    ghq
    nomad
    yt-dlp
  ];

  homebrew.casks = [
    "db-browser-for-sqlite"
    "google-chrome"
    "openscad"
    "visual-studio-code"
  ];
}
