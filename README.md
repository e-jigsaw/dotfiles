# dotfiles

## Installation

1. Install [GNU Stow](https://www.gnu.org/software/stow/).
2. Apply dotfiles for your environment:

```bash
# for macOS
stow -v -t ~ darwin

# for common settings
stow -v -t ~ --dotfiles common
```

Or via make (stow + vscode + claude-skills):

```bash
make install
```

## nix-darwin

```bash
# nix flake inputs を更新 (flake.lock)
make update

# 設定を適用 (sudo darwin-rebuild switch)。
#   LocalHostName が flake の構成名と一致すればそれを自動適用、
#   一致しなければ select メニューで選ぶ。HOST=<name> で明示指定も可。
make switch
make switch HOST=Iris
```

## Usage

### zsh aliases

| alias | description |
| ----- | ----------- |
| g     | git         |
| gs    | git status  |
| ggr   | git graph   |
| la    | ls -al      |
| @l    | pipe less   |
| @p    | pipe peco   |
| @c    | pipe pbcopy |

### herdr keybindings

prefix: `Ctrl-b`（押して離してから次のキーを入力）。`Shift` は大文字キーを表す。

[herdr v0.9.1 のデフォルト](https://github.com/herdrdev/herdr/blob/v0.9.1/src/config/model.rs)を使用し、[ローカル設定](darwin/.config/herdr/config.toml)でデタッチだけ `prefix + d` に変更している。

#### pane

| key | description |
| --- | ----------- |
| prefix + v | 右に分割 |
| prefix + - | 下に分割 |
| prefix + h/j/k/l | 左/下/上/右の pane に移動 |
| prefix + Shift-h/j/k/l | 左/下/上/右の pane と入れ替え |
| prefix + r | リサイズモード |
| prefix + z | pane 最大化トグル |
| prefix + x | pane を閉じる |
| prefix + [ | コピーモード |

#### tab

| key | description |
| --- | ----------- |
| prefix + c | 新規タブ |
| prefix + p / prefix + n | 前/次のタブ |
| prefix + 1..9 | タブ 1–9 に移動 |
| prefix + Shift-t | タブ名を変更 |
| prefix + Shift-x | タブを閉じる |

#### workspace / session

| key | description |
| --- | ----------- |
| prefix + w | ワークスペースナビゲーション |
| prefix + Shift-n | 新規ワークスペース |
| prefix + Shift-w | ワークスペース名を変更 |
| prefix + Shift-d | ワークスペースを閉じる |
| prefix + g | Goto ピッカー |
| prefix + b | サイドバー表示切り替え |
| prefix + d | デタッチ（プロセスは維持） |

#### other

| key | description |
| --- | ----------- |
| prefix + ? | 有効なキーバインドのヘルプ |
| prefix + s | 設定を開く |
| prefix + Shift-r | 設定リロード |

### neovim keybindings

[詳細な設定とキーバインド](darwin/.config/nix-darwin/nvim/README.md)

leader: `Space`

#### find / file tree

| key | description |
| --- | ----------- |
| Space + f f | ファイル名でファジー検索 |
| Space + f g | プロジェクト全体を grep |
| Space + f b | バッファ一覧 |
| Space + e | ファイルツリー開閉 (neo-tree) |

#### LSP

| key | description |
| --- | ----------- |
| g d | 定義へジャンプ |
| g r | 参照一覧 |
| K | ホバー (型・doc) |
| Space + r n | リネーム |
| Space + c a | コードアクション |
| [d / ]d | 前/次の診断へ |

#### edit / completion

| key | description |
| --- | ----------- |
| Space + w / Space + q | 保存 / 閉じる |
| Esc | 検索ハイライト消す |
| C-n / C-p | 補完候補 移動 |
| Tab | 選択中の候補を確定 |
| C-y | 補完確定 (Tab と同じ) |
| C-space / C-e | 補完を手動展開 / 閉じる |

## Author

- jigsaw (https://jgs.me)

## License

MIT
