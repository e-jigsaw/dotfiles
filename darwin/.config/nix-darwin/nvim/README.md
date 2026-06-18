# Nix 管理 Neovim (nixvim)

設定・プラグイン・LSP・Treesitter grammar を全部 Nix で宣言的に管理する Neovim 環境。
[nixvim](https://github.com/nix-community/nixvim) ベース。mason は使わず、LSP サーバと
grammar は **Nix 側で宣言してビルド済みを同梱**する。リモートでの実行時 DL / コンパイルは走らない。

このディレクトリ自体は単独の入力ではなく、`../flake.nix` がモジュールとして読み込む
(`makeNixvimWithModule { module = ./nvim; }`)。

## 構成

| ファイル | 役割 |
| --- | --- |
| `default.nix` | 集約・エイリアス・クリップボード・テーマ |
| `options.nix` | `vim.opt` 系・leader |
| `keymaps.nix` | キーマップ |
| `lsp.nix` | LSP サーバ定義 (vtsls / biome / lua_ls / nil / tailwindcss) |
| `treesitter.nix` | grammar (ビルド済み同梱) |
| `completion.nix` | blink.cmp |
| `telescope.nix` | ファジーファインダ |
| `ui.nix` | lualine / neo-tree / gitsigns / web-devicons |

## 入っているもの

- **LSP**: vtsls (TS/React), biome, lua-language-server, nil (Nix), tailwindcss-language-server
- **Treesitter**: typescript, tsx, javascript, nix, lua, json, html, css, markdown, markdown_inline, bash
- **補完**: blink.cmp
- **UI/操作**: telescope (+ ripgrep, fd), neo-tree, lualine, gitsigns, catppuccin (mocha)

## ローカル (Mac / nix-darwin)

`../flake.nix` の各 host に組み込み済み (`modules/neovim.nix` が `systemPackages` に追加)。
通常の rebuild で反映され、`vi` / `vim` / `nvim` すべてこの Neovim になる。

```bash
darwin-rebuild switch --flake ~/.config/nix-darwin
```

## リモート (Nix さえ入っていれば NixOS でなくてもよい)

単体パッケージ / app として export 済み。`nix run` 一発で設定込みで起動する。
初回起動時に grammar コンパイルや LSP ダウンロードは走らない (全部ビルド済み)。

```bash
# その場で起動 (撒くだけ)
nix run github:e-jigsaw/dotfiles?dir=darwin/.config/nix-darwin#nvim

# プロファイルに常駐させる
nix profile install github:e-jigsaw/dotfiles?dir=darwin/.config/nix-darwin#nvim
```

対応 system: `aarch64-darwin` / `x86_64-darwin` / `x86_64-linux` / `aarch64-linux`。

### ssh 越しのクリップボード (OSC52)

ssh セッション (`$SSH_TTY` 検出時) では yank が OSC52 経由でローカル端末のクリップボードへ飛ぶ。
端末側が OSC52 に対応している必要がある (ghostty / iTerm2 / kitty / WezTerm 等は対応)。
ローカル (非 ssh) では nixvim 既定のプロバイダ (Mac は pbcopy) を使う。

## ローカルでの動作確認

```bash
cd ~/.config/nix-darwin
nix build .#nvim -o /tmp/nvim && /tmp/nvim/bin/nvim
```
