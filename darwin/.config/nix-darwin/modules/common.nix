{ pkgs, self, ... }: {
  environment.systemPackages = with pkgs; [
    git
    vim
    ripgrep
    fastfetch
    starship
    ffmpeg
    fzf
    gemini-cli
    gh
    ghq
    git-lfs
    gnused
    gnupg
    gnutls
    go
    kubernetes-helm
    imagemagick
    jujutsu
    jq
    mise
    mysql80
    nomad
    pinentry_mac
    rustc
    cargo
    stow
    tailscale
    tmux
    unar
    wget
    yt-dlp
    awscli2
    poppler
  ];

  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

  users.users.jigsaw = {
    name = "jigsaw";
    home = "/Users/jigsaw";
  };
  system.primaryUser = "jigsaw";

  system.stateVersion = 5;

  nix.enable = false;

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.KeyRepeat = 2;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "1password/tap"
    ];
    brews = [];
    casks = [
      "1password-cli"
      "db-browser-for-sqlite"
      "ghostty"
      "google-chrome"
      "openscad"
      "visual-studio-code"
    ];
  };
}
