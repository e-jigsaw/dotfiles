# 新規マシンセットアップ

新しい Mac を一から設定する手順。

## 1. Xcode Command Line Tools

```bash
xcode-select --install
```

## 2. dotfiles リポジトリの clone

```bash
mkdir -p ~/dev/github.com/e-jigsaw
cd ~/dev/github.com/e-jigsaw
git clone git@github.com:e-jigsaw/dotfiles.git
```

## 3. Nix のインストール (Determinate Systems)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

インストール完了後、ターミナルを再起動。

## 4. GNU Stow で dotfiles を適用

```bash
cd ~/dev/github.com/e-jigsaw/dotfiles

# nix-darwin の設定ファイルを先に配置する
stow -v -t ~ darwin

# common 設定
stow -v --dotfiles -t ~ common
```

## 5. nix-darwin のセットアップ

```bash
cd ~/.config/nix-darwin
nix run nix-darwin -- switch --flake .
```

これにより以下がまとめて適用される:
- `environment.systemPackages` に列挙した CLI ツール群
- Homebrew Casks (ghostty, VSCode 等)
- macOS システム設定 (Dock, Finder, KeyRepeat)
- Nerd Fonts

## 6. mise でランタイムをインストール

```bash
# Node.js
mise install node@latest

# 必要に応じて
mise install deno@latest
```

## 7. GPG の設定

署名鍵をインポートして pinentry-mac を設定する。

```bash
# 鍵のインポート (バックアップから)
gpg --import /path/to/secret-key.asc

# pinentry-mac を設定
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

## 8. SSH 鍵の設定

GitHub 等に登録している SSH 鍵をバックアップから復元するか、新規生成して登録する。

```bash
# 新規生成する場合
ssh-keygen -t ed25519 -C "m@jgs.me"
cat ~/.ssh/id_ed25519.pub  # GitHub に登録
```

## 9. zsh の初期設定

`.zshrc` で Oh My Zsh を使っているため、初回起動時に自動インストールされる。されない場合は手動でインストール:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 完了確認

```bash
which starship   # starship が使える
which jj         # jujutsu が使える
mise list        # ランタイム確認
gpg --list-secret-keys  # GPG 鍵確認
```
