{ pkgs, herdr, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.jigsaw = {
    name = "jigsaw";
    home = "/Users/jigsaw";
  };
  system.primaryUser = "jigsaw";

  environment.systemPackages = with pkgs; [
    asciinema
    asciinema-agg
    ghq
    nomad
    vhs
    yt-dlp
    # flake input (github:herdrdev/herdr) から渡される
    herdr
    # pi-coding-agent の bin/pi は zsh の alias pi (pnpm install) と被るので tau として置く
    (runCommand "tau" { } ''
      mkdir -p $out/bin
      ln -s ${pi-coding-agent}/bin/pi $out/bin/tau
    '')
  ];

  homebrew.casks = [
    "db-browser-for-sqlite"
    "google-chrome"
    "openscad"
    "visual-studio-code"
  ];
}
