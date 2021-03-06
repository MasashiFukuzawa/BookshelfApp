※(2021.1.17) Herokuへのアクセスを停止しました。

# BookshelfAppについて

## コンセプト
- Railsチュートリアルで学んだ知識を定着、深化させるために制作
- 読んだ書籍を管理し、内容を記録・共有することができるアプリ

## 制作のきっかけ
- 読了した技術書の共有や内容のメモをできる場所が欲しかった
- このようなアプリがあれば、他のエンジニアが読むべき本にすぐにキャッチアップできるようになると考えたから

## 重視した点
- あらかじめGitHubでIssueを作成し、それに沿って制作を進めた
- ブランチを切って制作を進める、プルリクエストでコードレビューを受け許可が出た後本 番環境にマージするなど、なるべく実務に近い形で制作を進めた
- テンプレートエンジンとしてSlimを用いた ・敢えてDeviseは用いずに、仕組みを学ぶために自力で認証系を実装した

## 技術内容
- 言語:Ruby
- テンプレートエンジン:Slim
- フレームワーク:Ruby on Rails
- DB:SQLite (開発環境), PostgreSQL (本番環境)
- バージョン管理:Git
- インフラ:Heroku

## 実装した機能等の概要
- 記事一覧表示機能
- 詳細表示機能
- 記事投稿機能
- ユーザー登録機能
- ログイン機能
- ユーザーフォロー機能
- 画像ファイルのアップロード機能
- DBテーブルのリレーション機能
- ページネーション機能
- 単体テスト、統合テスト(MiniTestを使用)
