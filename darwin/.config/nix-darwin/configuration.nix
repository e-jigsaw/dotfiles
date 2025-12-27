{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    vim
    ripgrep
    neofetch
    starship
    ffmpeg
    fzf
    gemini-cli
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
    unar
    wget
    yt-dlp
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User configuration
  users.users.jigsaw = {
    name = "jigsaw";
    home = "/Users/jigsaw";
  };
  system.primaryUser = "jigsaw";

  # Set Git revision for system.configurationRevision.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # Determinate detected, aborting activation
  nix.enable = false;

  # macOS system settings
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.KeyRepeat = 2;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
  ];

  # Homebrew integration
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "1password/tap"
    ];
    brews = [
    ];
    casks = [
      "1password-cli"
      "db-browser-for-sqlite"
      "google-chrome"
      "openscad"
      "visual-studio-code"
    ];
  };
}
