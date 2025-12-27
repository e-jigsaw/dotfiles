{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    vim
    ripgrep
    neofetch
    starship
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

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
      "hashicorp/tap"
    ];
    brews = [
      "gnutls"
      "ffmpeg"
      "fzf"
      "gemini-cli"
      "ghq"
      "git"
      "git-lfs"
      "gnu-sed"
      "gnupg"
      "go"
      "helm"
      "imagemagick"
      "jj"
      "jq"
      "mise"
      "mysql"
      "pinentry-mac"
      "rust"
      "stow"
      "tailscale"
      "unar"
      "wget"
      "youtube-dl"
      "hashicorp/tap/nomad"
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
