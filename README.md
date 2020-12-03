# Herokuへのデプロイ手順
***
1. アセットプリコンパイルをする。
<br>$ rails assets:precompile RAILS_ENV=production　を実行する
2. コミットする。
<br>git add、git commit -m "コメント"、git push origin masterを実行する。
3. Herokuに新しいアプリケーションを作成する。
<br>$ heroku createを実行する
4. Heroku buildpackを追加する
<br>$ heroku buildpacks:set heroku/ruby　を実行する
<br>$ heroku buildpacks:add --index 1 heroku/nodejs　を実行する
5. Herokuにデプロイする
<br>git push heroku master　を実行する
6. データベースを移行する
<br>$ heroku run rails db:migrate


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
