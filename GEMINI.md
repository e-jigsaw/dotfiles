# Project Context for Gemini

## 1. Project Overview

- **Name:** dotfiles
- **Description:** macOS (darwin) 環境の設定ファイル (zsh, git, etc.) を管理するプロジェクト。GNU Stow を使用してホームディレクトリに symlink を配置する運用。
- **Goals:** 効率的で再現性のある開発環境の維持。新しいツールの導入や既存設定の最適化。

## 2. Tech Stack

- **Shell:** zsh (Oh My Zsh, theme: fino-time)
- **Tool Management:** mise, Homebrew
- **Development Runtimes:** Node.js (via mise/pnpm/bun), Go, Deno
- **Version Control:** git, jujutsu (jj)
- **Utilities:** fzf, gpg, GNU Stow, 1Password CLI (op)

## 3. Coding Standards & Rules

- **Directory Structure:**
  - `darwin/`: macOS 固有の設定ファイル (`.zshrc`, `.gitconfig` など)。
  - `common/`: OS に依存しない共通設定 (`.jjconfig.toml` など)。
- **Style:**
  - 設定ファイルは可読性を重視し、セクションごとにコメントで区切る。
  - zsh のエイリアスは短く直感的なものにする (例: `g` -> `git`, `d` -> `deno`)。
- **Deployment:**
  - 変更後は `stow -v -t ~ darwin` (または `common`) で適用することを意識する。

## 4. Nix Configuration

- **Status:** `nix-darwin` (Flakes enabled) is currently used for system configuration and package management alongside Homebrew.
- **Location:** `darwin/.config/nix-darwin/`
  - `flake.nix`: Entry point defining dependencies and inputs.
  - `configuration.nix`: System-wide settings (packages, macOS defaults, Homebrew integration).
- **Key Settings:**
  - `nix.enable = false`: Determinate Systems installer handles the Nix daemon, so `nix-darwin` management is disabled to avoid conflicts.
  - `homebrew.enable = true`: Integrates Homebrew management.
- **Operation:**
  - Apply changes: `darwin-rebuild switch --flake ~/.config/nix-darwin`
  - Update inputs: `nix flake update` (inside `~/.config/nix-darwin`)
  - Garbage collection: `nix-collect-garbage -d`

## 5. Instructions

- コード生成時は、まず `GEMINI.md` の内容を前提として理解すること。
- 生成されたコードに不明点がある場合は、勝手に補完せず質問すること。
- ステップ毎に `jj describe` コマンドを実行してトレースできるようにすること。
