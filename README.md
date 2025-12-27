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
stow -v -t ~ common
```

# Author

- jigsaw(http://jgs.me)

# License

MIT
