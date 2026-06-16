---
name: gitlab-cli
description: GitLab上のIssueやMerge Request（MR）を確認・検索・操作する際に呼び出すスキル。
---

# GitLab CLI (`glab`) の使用ルール

このプロジェクトにおいて、GitLab の Issue や Merge Request (MR) に関する情報を取得したり操作したりするタスクを与えられた場合は、必ず `glab` コマンドを実行して確認してください。

## 主なコマンドの例

AI エージェントは、タスクに応じて以下のコマンドをシェルで実行し、出力を読み取って回答や処理に役立ててください。

### Issue の確認

* Issue一覧の取得: `glab issue list`
* 特定のIssueの詳細確認: `glab issue view <issue-number>`
* 自分にアサインされたIssueの確認: `glab issue list --assignee=@me`

### Merge Request (MR) の確認

* MR一覧の取得: `glab mr list`
* 特定のMRの詳細・差分確認: `glab mr view <mr-number> --output json`
* 特定のMRのレビュー（コメント）確認: `glab mr view <mr-number> --comments --output json`

## 注意事項

* コマンドの実行結果が長すぎる場合は、必要に応じて `grep` などを組み合わせて必要な情報を絞り込んでください。
* `glab` コマンドは既に認証済みであることを前提とします。もし認証エラーが出た場合は、ユーザーに報告してください。
