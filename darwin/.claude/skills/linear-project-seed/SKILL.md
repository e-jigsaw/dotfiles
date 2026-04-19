---
name: linear-project-seed
description: "Linear に新しい project を作って、関連する issue をまとめて書き出すときに使う。ユーザが「project を切って issue 出したい」「Linear に今日やる分の project 作って」「このセッションぶんを Linear にまとめて」等と依頼した時に起動する。対応する project が存在しない状態で issue を起票しようとしている時にも使う (jigsaw のルール: issue は必ず project に紐付ける)。Use this skill to create a new Linear project and seed it with issues in one flow."
---

# Linear Project Seed

Linear に新しい project を作って、そこにぶら下がる issue をまとめて起票する。jigsaw のグローバルルール「issue は必ず project に紐付ける」を満たすための起点。

## 何をするか

1. team を確定する (複数 team あれば選ばせる)
2. project を 1 つ `save_project` で作る
3. その project に紐付く issue を `save_issue` で複数起票する
4. 起票結果を要約して返す

priority / cycle の整理は **別 skill (linear-cycle-tidy 相当) の担当**。この skill では触らない。

## 使うツール

- `mcp__claude_ai_Linear__list_teams` — team 一覧
- `mcp__claude_ai_Linear__list_projects` — 同名 project が既にないか確認
- `mcp__claude_ai_Linear__save_project` — project 作成
- `mcp__claude_ai_Linear__save_issue` — issue 起票 (project を必ず指定)

## フロー

### 1. 入力を固める

ユーザの依頼から以下を決める。足りなければ聞く。

- **team** — `list_teams` を呼んで候補を出す。1 つしか無ければ黙ってそれを使う。複数あれば聞く
- **project name** — 名前。既存 project と被らないか `list_projects` で軽く確認
- **project description** — 目的を 1-3 行。markdown 可
- **issues** — 各 issue の title と body。body は問題・受入条件がはっきりするくらい具体的に。priority や assignee は付けない

聞くのは最小限。ユーザが既にタイトルを並べてくれているなら body は自分で肉付けして確認だけ取る。

### 2. project を作る

```
save_project({
  team: <teamId>,
  name: <project name>,
  description: <markdown>,
})
```

戻り値の project ID を控える。

### 3. issue を連続起票

各 issue に対して:

```
save_issue({
  team: <teamId>,
  project: <projectId>,  // 必須
  title: <title>,
  description: <markdown body>,
})
```

**並列化しない**。順番に起票して、失敗したらそこで止めて報告する (途中まで入った状態をユーザに見せる)。

### 4. 出力

- project の URL
- 起票した issue の identifier と title の一覧

余計なサマリは付けない。

## やらないこと

- priority / estimate / cycle / label の付与 → cycle tidy 側の責任
- assignee 設定 → 独り運用なのでデフォルトのままでよい
- 既存 project への issue 追加 → その用途なら素直に `save_issue` を直接呼べばよく、この skill を起動する必要は無い
- status update の投稿 → `linear-status-update` skill の責任

## 失敗時

- team が引けない → ユーザに Linear MCP の接続確認を促す
- project 名が既存とぶつかる → ユーザに別名 or 既存 project 使うかを聞く
- issue 起票の途中で落ちた → どこまで入ったか報告して中断。勝手にリトライしない
