# nix-darwin 導入計画書

## 1. 概要

本計画は、macOS 環境の管理を `nix-darwin` (Flakes ベース) に移行するための手順書です。段階的に導入を進めることで、既存環境への影響を最小限に抑えつつ、宣言的な構成管理を実現します。

## 2. ディレクトリ構成案

設定ファイルは `~/.config/nix-darwin` (または `~/nix-darwin`) で管理し、Git でバージョン管理することを推奨します。

```
~/nix-darwin/
├── flake.nix             # エントリポイント (依存関係と構成定義)
├── flake.lock            # 依存関係のロックファイル (自動生成)
├── configuration.nix     # システム設定 (macOS 全体)
└── home.nix              # ユーザー設定 (Home Manager, dotfiles) [Optional]
```

## 3. 導入フェーズ

### Phase 0: GNU Stow による dotfiles 管理の開始

Nix を導入する前に、既存の dotfiles を `stow` で管理下に置き、シンプルに管理します。現在の「OS ごとにディレクトリを分ける」構成（`darwin/` など）と相性が良い方法です。

1. **stow のインストール**

   ```bash
   brew install stow # または nix-env -iA nixpkgs.stow
   ```

2. **シンボリックリンクの作成**

   `dotfiles` ディレクトリに移動し、現在の OS に対応するパッケージ（ディレクトリ）を適用します。

   ```bash
   cd ~/dev/github.com/e-jigsaw/dotfiles
   stow -v darwin
   # 共通設定がある場合: stow -v common
   ```

   これにより、`~/dev/github.com/e-jigsaw/dotfiles/darwin/.zshrc` などへのシンボリックリンクがホームディレクトリに作成されます。

3. **確認**

   `ls -l ~/.zshrc` などでリンクが正しく張られているか確認します。

### Phase 1: 準備 (Nix のインストール)

dotfiles 管理が安定したら、土台となる Nix パッケージマネージャーを導入します。

1. **Nix のインストール** (Determinate Systems 推奨)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
2. **シェル再起動**: インストール完了後、ターミナルを再起動。
3. **Flakes の有効化確認**: `nix.conf` に `experimental-features = nix-command flakes` が含まれているか確認。

### Phase 2: 最小構成の構築 (Hello World)

`nix-darwin` を Flake ベースで初期化し、適用できるか確認します。

1. **ディレクトリ作成**
   ```bash
   mkdir -p ~/.config/nix-darwin
   cd ~/.config/nix-darwin
   ```
2. **flake.nix の作成** (最小テンプレート)
   ```nix
   {
     description = "My Darwin Configuration";
     inputs = {
       nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
       nix-darwin.url = "github:lnl7/nix-darwin";
       nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
     };
     outputs = inputs@{ self, nix-darwin, nixpkgs }:
     let
       configuration = { pkgs, ... }: {
         environment.systemPackages = [ pkgs.neofetch ];
         services.nix-daemon.enable = true;
         nix.settings.experimental-features = "nix-command flakes";
         system.configurationRevision = self.rev or self.dirtyRev or null;
         system.stateVersion = 5;
       };
     in {
       darwinConfigurations."HOSTNAME" = nix-darwin.lib.darwinSystem { # HOSTNAMEは `scutil --get LocalHostName` の値
         modules = [ configuration ];
       };
     };
   }
   ```
3. **初回ビルド & 適用**
   ```bash
   nix run nix-darwin -- switch --flake .
   ```
   _成功すれば `neofetch` コマンドが使えるようになります。_

### Phase 3: 設定の拡充

システム設定と Homebrew 連携を追加します。

1. **configuration.nix の作成**
   ```nix
   { pkgs, ... }: {
     environment.systemPackages = with pkgs; [ git vim ripgrep ];
     system.defaults = {
       dock.autohide = true;
       finder.AppleShowAllFiles = true;
       NSGlobalDomain.KeyRepeat = 2;
     };
     homebrew = {
       enable = true;
       onActivation.cleanup = "zap";
       brews = [ "mas" ];
       casks = [ "google-chrome" "visual-studio-code" ];
     };
   }
   ```
2. **flake.nix の修正**: `modules = [ ./configuration.nix ];` に変更。

### Phase 4: Home Manager の導入 (Optional)

1. **flake.nix に inputs 追加**: `home-manager` を追加。
2. **home.nix の作成**: ユーザー固有の設定を記述。
3. **modules に home-manager 追加**:
   ```nix
   modules = [
     ./configuration.nix
     home-manager.darwinModules.home-manager
     {
       home-manager.useGlobalPkgs = true;
       home-manager.useUserPackages = true;
       home-manager.users.USER_NAME = import ./home.nix;
     }
   ];
   ```

## 4. 運用・保守

- **設定の適用**: `darwin-rebuild switch --flake ~/.config/nix-darwin`
- **アップデート**: `nix flake update` してから switch
- **ガベージコレクション**: `nix-collect-garbage -d`

## 5. 注意事項

- **既存の dotfiles との競合**: バックアップを推奨。
- **ディスク容量**: 定期的な掃除が必要。
