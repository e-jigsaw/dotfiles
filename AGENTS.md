# AGENTS.md

このリポジトリで作業するコーディングエージェント向けのガイド。

## Overview

macOS (darwin) の dotfiles を GNU Stow と nix-darwin (Flakes) で管理するリポジトリ。

- `darwin/`: macOS 固有の設定ファイル (`.zshrc`, `.gitconfig`, nix-darwin フレーク等)
- `common/`: OS 非依存の共通設定 (`.jjconfig.toml` 等)

## 設定の適用

```bash
# darwin 設定を適用 (GNU Stow)
stow -v -t ~ darwin

# common 設定を適用
stow -v -t --dotfiles ~ common

# nix-darwin 設定を適用 (リポジトリ直下で)
make switch

# nix flake inputs の更新 (リポジトリ直下で)
make update

# Nix ガベージコレクション
nix-collect-garbage -d
```

nix-darwin の switch は `darwin-rebuild switch` を直接叩かず `make switch` を使う。`LocalHostName` から flake の構成名 (`darwinConfigurations.<host>`) を選んで `sudo darwin-rebuild switch --flake ~/.config/nix-darwin#<host>` を実行してくれる。ホストを明示したい時は `make switch HOST=<name>`。sudo のパスワードが要るので、エージェントからは実行できない。ユーザに `! make switch` を打ってもらう。

## Architecture

### GNU Stow によるシンボリックリンク管理

`darwin/` 以下のファイルが `~` にシンボリックリンクされる。`common/` は `--dotfiles` オプションで `dot-` プレフィックスを `.` に変換して配置。

### nix-darwin フレーク

`darwin/.config/nix-darwin/` に配置。Determinate Systems インストーラーで Nix デーモンを管理するため `nix.enable = false`。Homebrew 統合あり (`homebrew.enable = true`)。対象ホスト: `JigsawStudio` (aarch64-darwin)。

パッケージは Nix (`configuration.nix` の `environment.systemPackages`) と Homebrew Casks の両方で管理している。

`JigsawMini` は セルフホストの Forgejo の Actions runner を常駐させている (`modules/forgejo-runner.nix`)。専用ユーザ `forgejo-runner` の launchd daemon で、label は `mini`。job は container 無しで mini の上で直接走る。

Forgejo への接続情報 (URL、UUID、token) は repo に置かず、mini の `/var/lib/forgejo-runner/connection.yaml` に手で書く。daemon は起動時に `/etc/forgejo-runner/config.yaml` とこのファイルを繋げて設定にする。ファイルが無い間は起動せず待つ。

Forgejo の Settings → Actions → Runners で runner を作ると UUID と token が出るので、mini で次を実行する。`forgejo-runner register` は deprecated で使わない。

```bash
sudo -u forgejo-runner tee /var/lib/forgejo-runner/connection.yaml >/dev/null <<'YAML'
server:
  connections:
    forgejo:
      url: <Forgejo の URL>
      uuid: <UUID>
      token: <token>
YAML
sudo chmod 600 /var/lib/forgejo-runner/connection.yaml
sudo launchctl kickstart -k system/org.nixos.forgejo-runner
```

label は `/etc/forgejo-runner/config.yaml` の `runner.labels` が使われる。ログは `/var/lib/forgejo-runner/runner.log`。

### バージョン管理

Git と jujutsu (jj) を並行して使用。`.gitconfig` で GPG 署名が強制されている (`commit.gpgsign = true`)。`init.defaultBranch` は `m` だが、このリポジトリのデフォルトブランチは `main`。

## スタック

- **Shell:** zsh + Oh My Zsh (theme: fino-time)
- **プロンプト:** Starship
- **ツールバージョン管理:** mise
- **パッケージ管理:** Nix (nix-darwin) + Homebrew
- **VCS:** git + jujutsu
- **ランタイム:** Node.js (pnpm/bun), Go, Deno

## 設定スタイル

- zsh エイリアスは短く直感的に (`g` → git, `d` → deno, `p` → pnpm, `b` → bun)
- 設定ファイルはセクションごとにコメントで区切る
