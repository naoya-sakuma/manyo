#Herokuへのデプロイ手順
***
1. アセットプリコンパイルをする。
'$ rails assets:precompile RAILS_ENV=production　を実行する'
2. コミットする。
'git add、git commit -m "コメント"、git push origin masterを実行する。'
3. Herokuに新しいアプリケーションを作成する。


# Taskモデル、tasksテーブル
|Column|Type|
|------|----|
|task_id|integer|
|title|string|
|content|text|
|priority|status|
|deadline|date|

# Userモデル、usersテーブル
|Column|Type|
|------|----|
|user_id|integer|
|name|string|
|email_adress|string|
|password_digest|string|
