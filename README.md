# dotfiles

# Usage

## zsh aliases

| alias | description |
| ----- | ----------- |
| g     | git         |
| gs    | git status  |
| ggr   | git graph   |
| la    | ls -al      |
| @l    | pipe less   |
| @p    | pipe peco   |
| @c    | pipe pbcopy |

## tmux keybindings

prefix: `C-b`

### pane

| key | description |
| --- | ----------- |
| prefix + \| | 横分割 |
| prefix + - | 縦分割 |
| prefix + h/j/k/l | pane 移動 |
| prefix + H/J/K/L | pane リサイズ |
| prefix + z | pane 最大化トグル |
| prefix + x | pane を閉じる（確認あり） |

### window

| key | description |
| --- | ----------- |
| prefix + c | 新規ウィンドウ |
| prefix + & | ウィンドウを閉じる |
| S-Left / S-Right | 前/次のウィンドウ |

### session

| key | description |
| --- | ----------- |
| prefix + s | セッション選択 |
| prefix + w | ウィンドウツリー |
| prefix + d | デタッチ |

### other

| key | description |
| --- | ----------- |
| prefix + r | 設定リロード |

## yazi keybindings

### navigation

| key | description |
| --- | ----------- |
| h / j / k / l | 親/下/上/子 に移動 |
| H / L | 履歴 戻る / 進む |
| g g / G | 先頭 / 末尾 |
| K / J | プレビューを上/下スクロール |

### file ops

| key | description |
| --- | ----------- |
| Space | 選択トグル |
| y / x / p | yank / cut / paste |
| d / D | ゴミ箱へ / 完全削除 |
| a / r | 新規作成 / リネーム |
| o / Enter | 開く |
| ; / : | シェル実行 (ブロックなし / ブロック) |

### jump / search / filter

| key | description |
| --- | ----------- |
| z / Z | zoxide / fzf ジャンプ |
| . | 隠しファイル表示トグル |
| / / n | find / 次の find 候補 |
| s / S | fd 検索 / rg 検索 |
| f | filter |

### tab / quit

| key | description |
| --- | ----------- |
| t | 新規タブ |
| [ / ] | 前/次のタブ |
| 1-9 | タブ切替 |
| q / Q | cwd 反映して終了 / 反映せず終了 |

## neovim keybindings

[darwin/.config/nix-darwin/nvim/README.md](https://github.com/e-jigsaw/dotfiles/blob/main/darwin/.config/nix-darwin/nvim/README.md)

leader: `Space`

### find / file tree

| key | description |
| --- | ----------- |
| Space + f f | ファイル名でファジー検索 |
| Space + f g | プロジェクト全体を grep |
| Space + f b | バッファ一覧 |
| Space + e | ファイルツリー開閉 (neo-tree) |

### LSP

| key | description |
| --- | ----------- |
| g d | 定義へジャンプ |
| g r | 参照一覧 |
| K | ホバー (型・doc) |
| Space + r n | リネーム |
| Space + c a | コードアクション |
| [d / ]d | 前/次の診断へ |

### edit / completion

| key | description |
| --- | ----------- |
| Space + w / Space + q | 保存 / 閉じる |
| Esc | 検索ハイライト消す |
| C-n / C-p | 補完候補 移動 |
| C-y | 補完確定 (Enter ではない) |
| C-space / C-e | 補完を手動展開 / 閉じる |

# Installation

1. Install [GNU Stow](https://www.gnu.org/software/stow/).
2. Apply dotfiles for your environment:

```bash
# for macOS
stow -v -t ~ darwin

# for common settings (if exists)
stow -v -t ~ --dotfiles common
```

# Author

- jigsaw (https://jgs.me)

# License

MIT
