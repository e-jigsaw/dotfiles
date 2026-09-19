{ pkgs, self, ... }: {
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    fastfetch
    starship
    ffmpeg
    fzf
    gemini-cli
    gh
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
    mysql84
    oh-my-zsh
    pinentry_mac
    rustc
    cargo
    clippy
    stow
    tailscale
    tmux
    unar
    wget
    awscli2
    poppler-utils
    yazi
    zoxide
  ];

  # oh-my-zsh は share/oh-my-zsh 配下のみ持つので pathsToLink に足さないと
  # systemPackages に入れても /run/current-system/sw に展開されない
  environment.pathsToLink = [ "/share/oh-my-zsh" ];

  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

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
    onActivation = {
      cleanup = "zap";
      # 非対話の activation で cleanup を走らせるには force が要る
      # (brew 6.x は --cleanup に --force/--force-cleanup/$HOMEBREW_ASK を要求。
      #  HOMEBREW_ASK は対話確認なので switch では使えない)
      extraFlags = [ "--force-cleanup" ];
    };
    taps = [
      "1password/tap"
    ];
    brews = [];
    casks = [
      "1password-cli"
      "ghostty"
    ];
  };
}
