---
name: linear-status-update
description: "Linear の project に status update (進捗報告) を投稿するときに使う。ユーザが「project update 書いて」「今日やったぶんを Linear に残して」「status update 投げて」等と依頼した時に起動する。git log や Linear 上の issue の動きから進捗素材を集めて、project status update として投稿する。Use this skill to post a project status update to Linear summarizing recent progress."
---

# Linear Status Update

現在進行中の Linear project に対して、ここまでの進捗をまとめて project status update として投稿する。

## 何をするか

1. 対象の project を特定する
2. 直近の進捗素材を集める (git log / Linear issue の変化)
3. markdown で本文を組み立てる
4. `save_status_update(type=project)` で投稿する

## 使うツール

- `mcp__claude_ai_Linear__list_projects` — project 検索
- `mcp__claude_ai_Linear__get_project` — project の詳細と直近の update 参照
- `mcp__claude_ai_Linear__get_status_updates` — 既存 update の確認 (重複・差分を取るため)
- `mcp__claude_ai_Linear__list_issues` — project 配下の issue 状況
- `mcp__claude_ai_Linear__save_status_update` — 投稿 (`type: "project"`)
- `Bash` (`git log`, `git diff` 等) — ローカルで起きた変化を拾う

## フロー

### 1. project の特定

以下の優先順で推測する。推測したら「この project で合ってる?」と 1 回確認する。

1. ユーザが名前を指定した → `list_projects` で該当を取る
2. 現在のリポジトリ直下の CLAUDE.md / 直近の会話文脈で対象 project が自明 → それを候補に出す
3. どちらも無理 → `list_projects`(最近更新の多いもの) を見せて選ばせる

### 2. 進捗素材を集める

**ローカル側**

- `git log --since=<最後の update から> --oneline` で commit ログ
- 必要に応じて `git log --stat` or `git diff --stat` で規模感
- コミットメッセージの issue prefix (CMS-xx など) から紐付く issue を抜く

**Linear 側**

- `get_project` で前回 update を見て、そこからの差分を見る
- `list_issues(project=<id>, updatedAt >= <cutoff>)` で動いた issue を取る
- 完了 / 新規 / 進行中で分ける

### 3. 本文を組み立てる

**口調**: jigsaw のくだけた日本語。「です・ます」避ける。相槌・前置き・褒め無し。

**構造** (固定テンプレートではなく目安):

```markdown
## やったこと

- CMS-xx: 〜〜を〜〜した
- CMS-yy: 〜〜を修正

## 今どうなってる

現状の到達点を 1-2 文

## 次

- 次に倒す予定の issue (あれば)
```

ルール:

- issue identifier (CMS-xx) はそのまま残す (Linear が自動 link する)
- コミット hash は書かない (ノイズ)
- 「深夜にやった」等の感傷的な内容は書かない
- 1 項目 1 行。長文化させない
- 前回 update と重複する完了項目は書かない

### 4. health を決める

`save_status_update` は health を取る。以下の指針で選ぶ。聞かずに決めて良い。迷ったら `onTrack`。

- `onTrack` — 通常進捗
- `atRisk` — 詰まってる issue がある / 方針見直しが必要
- `offTrack` — 手が止まってる / ブロック中

### 5. 投稿

```
save_status_update({
  project: <projectId>,
  type: "project",
  health: <selected>,
  body: <markdown>,
})
```

**投稿前に本文をユーザに見せて確認を取る**。status update は外から見える進捗ログなので、ユーザに 1 度見せてから投げる。

### 6. 出力

投稿した update の URL を返して終了。要約は要らない (本文がすでに要約)。

## やらないこと

- issue の status 変更 → update の文面で「完了した」と書くだけ。実際のステータス変更は別作業
- initiative / milestone の status update → この skill は `type: "project"` 固定
- 複数 project に同じ update を投げる → 1 project 1 update

## 失敗時

- project が特定できない → 候補を出してユーザに選ばせる
- git log が取れない (repo 外で呼ばれた) → ユーザから素材を貰うモードに切り替える
- 投稿が失敗した → 下書きを残して理由を報告。自動リトライしない
