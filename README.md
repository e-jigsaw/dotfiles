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

# Installation

1. Install [GNU Stow](https://www.gnu.org/software/stow/).
2. Apply dotfiles for your environment:

```bash
# for macOS
stow -v -t ~ darwin

# for common settings (if exists)
stow -v -t ~ --dotfiles common
```

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

### other

| key | description |
| --- | ----------- |
| prefix + r | 設定リロード |

# Author

- jigsaw(http://jgs.me)

# License

MIT
