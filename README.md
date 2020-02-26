# README

# Ryouoku_app
ご覧いただきありがとうございます。
私はスクールを卒業し、現在も日々プログラミング学習をしております。このアプリケーションは美味しいものを食べたくて、料理はやってみたいけれど、敷居が高くてなかなかできない人向けの料理も手軽に体験できて、食べられる体験シェアマッチングアプリです。
* コンセプトとしては、イベント出展機能や、イベント参加者が料理お手伝いをすると割引になる機能、参加者同士のDM機能などで自分がやったことのない機能にチャレンジする。
* 最終課題の時の経験を活かした機能を実装する。(アウトプット)
* hamlでのマークアップに慣れてきて忘れがちなため、HTMLを用いる。
などの目標を立て制作を行いました。

* url:http://13.230.196.160:3000/

* テスト用アカウント
<br>出展者・予約者用
<br>メールアドレス: test15@gmail.com	
<br>パスワード: sssssss

<!-- * Basic認証
<br>ID: 
<br>Pas
sword:  -->
<!-- # 開発メンバー
* 小山薫 -->
# プレビュー
トップページ<br>
<img src="https://i.gyazo.com/12aa05b485157026fb5217495c058b55.png" alt="Image from Gyazo" width="790"/>

イベント参加者DMルーム<br>
<img src="https://i.gyazo.com/91efe125aef36c25fa33c95eb4c6608e.png" alt="Image from Gyazo" width="1069"/>

イベント予約確認ページ（料理お手伝い割引機能）<br>
<img src="https://i.gyazo.com/415618f2f3b0849b1ee7b09e6f80d199.png" alt="Image from Gyazo" width="1069"/>
<br>
# 制作環境
* Ruby on Rails '5.2.3'
* mysql2 '>= 0.4.4', '< 0.6.0'
* AWS、S3を用いたデプロイと画像の保存。

# 使い方
## 実装済み部分
* メールアドレスによるログインができます。
* イベントを予約したい方は、予約確認ページからイベント情報が確認でき、出展者が提示する料理のお手伝い項目から自分がやってみたい項目の選択にチェックを入れるとその分安くイベントに参加できるようになります。
* イベント参加者用DMルームでは参加者同士でDMが送れるようにして、投稿したDMが見れるようになっております。
* ログインしていない状態でも出展の詳細をご覧になれますが、予約したり出展することはできません。
* 新規登録が完了すると、イベントを出展することができます。必須項目を入力すると出展できます。写真は5枚まで添付することができます。(開催日時・場所・料理お手伝い項目の入力画面は別途作成中です)
## これから実装する部分
* S3による画像アップロード
* トップページは出展されたイベントが新しい順に並べます。ページネーションによって5ページずつ表示されるようにします。
* イベント出展入力項目で開催日時・場所・料理お手伝い項目の入力画面は別途作成中です
* 出展したイベントは、詳細画面より編集・削除ができます。
* イベントを予約する際は、クレジットカード情報(サンプルサイトなので仮番号)を入力することで予約処理が完了します。
* キーワードでタイトルから出展されたイベントをあいまい検索ができるようにする。


## 工夫した点
* 技術と知識の未熟さから必須機能の全ての完全再現は難しかったが、持てる知識をうまく活用することで部分的に再現できました。
* 夜間コースのチームメンバーやライフコーチに個人アプリの意見を聞いたり相談をして、実装に活かすことができました。
* スクールの最終課題では担当していなかった部分を重点的に復習も兼ねて、特に出展機能は個人的にやってみたかったので力を入れて実装しました。
* イベント出展においてカメラアイコンをクリックすることによりプレビューの画像を表示させました。
* 料理お手伝い割引機能を導入しました。

## 改善点
* JSを用いた動きや通信が少なく、全体的に寂しいWebサイトという印象が感じられると思いました。時間が取れなくて再現できなかった部分も多いので、これからも少しずつ手を加えていきたいと考えております。
* DB設計に関して、よく考えたつもりでも後から修正することが多く、様々な視点から情報を捉えることが重要だと感じました。
* 画像アップロードのUIにはまだ使いにくい部分もあると感じました。画像ファイル選択後の「削除」ボタンがまだ効かないのでこれからここを工夫して実装したいと思います。
* ページのデザインや配置などがシンプルで、JSを使ったりして、見た目・動き・わかりやすさにまだ改良の余地があると感じました。
* AWSを用いてデプロイしましたが、なかなか手順に慣れず時間がかかってしまいました。何回もやってAWSでのデプロイに慣れてきたらHeroku等もチャレンジしてみようと思います。
* タグでイベントを絞り込めるような機能が必要かなと思いました。


# DB設計

## ER図
<img width="1194" src="https://i.gyazo.com/fb829f0c6e2bc3c19068547fc9e5412d.png">

##  usersテーブル

|Column|Type|Options|
|------|----|-------|
|email|string|null: false,unique: true|
|name |string|null: false|
|password |string|null: false|
|profile|text||

<!-- 以下でaccepts_nested_attributes_forを定義し、親子関係のある関連モデルで、親モデル作成と同時に子モデルも作成する -->
### Association
- has_many :messages
- has_many :events
- has_many :messages
- has_many :cards
- has_many :evaluations
- has_many :events, through: :messages
- has_one:personal
- accepts_nested_attributes_for :personal
- has_one :address
- accepts_nested_attributes_for :address



## addressテーブル
イベント開催日時・開催場所を登録するテーブル

|Column|Type|Options|
|------|----|-------|
|event_id|integer|null: false, foreign_key: true|
|date|string|null: false|
|time|string|null: false|
|postcode|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|phone_number|string||
|figure|text|null: false|
<!-- 余裕があればgooglemapが表示できるようにしたい↓ -->



### Association

- belongs_to :event

## eventsテーブル
出展されたイベントは複数の画像を投稿でき、
<br>開催名・場所・日時、キャッチコピー等をつけることができ、イベント価格や予約状況なども確認できるようにする。

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|description|text|null: false|
|capacity|string|null: false|
|place|string|null: false|
|price|integer|null: false|
|category_id|integer|null: false, foreign_key: true|
|exhibitor_id|integer|null: false, foreign_key: true|
|buyer_id|integer|foreign_key: true|
|prefecture_id|integer|null: false, foreign_key: true|


### Association

<!-- 以下の記述により、userテーブルの「id」**とeventsテーブルの「buyer_id」「exhibitor_id」が紐づくようになります。 -->

- belongs_to :exhibitor, class_name: “User”
- belongs_to :buyer, class_name: “User”
- belongs_to :prefecture
- belongs_to :category
- has_many :messages
- has_many :images
- has_many :users, through: :messages

## cooksテーブル
イベントそれぞれの料理工程を登録するためのテーブル
|Column|Type|Options|
|------|----|-------|
|event_id|integer|null: false, foreign_key: true|
|level1|string|null: false|
|level2|string|null: false|
|level3|string|null: false|
|level4|string|null: false|
|level5|string|null: false|

### Association
- belongs_to event

## prefecturesテーブル
イベント出展場所やユーザの住所等の情報として使用

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association

- has_many :users
- has_many :events
- has_many :personals
- has_many :addresses

## categoriesテーブル
一つのカテゴリーはたくさんのイベントを持っている
ancestry(gem)によってツリー構造（階層）として編成する予定

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|index?|

### Association

- has_many :events
- has_ancestry

## imagesテーブル
イベント一つの出展に複数の画像投稿が可能

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|event_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :event

## messagesテーブル
イベント予約者トークページで出展者と参加者が気軽に交流できるようにする
|Column|Type|Options|
|------|----|-------|
|user_id |integer|null: false, foreign_key: true|
|event_id |integer|null: false, foreign_key: true|
|content|text|
|image|string|

### Association
- belongs_to :user
- belongs_to :event

## entriesテーブル
どのユーザーがどのイベントを予約しているかわかるようにするテーブル
|Column|Type|Options|
|------|----|-------|
|user_id |integer|null: false, foreign_key: true|
|event_id |integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :event

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association

- belongs_to :user
<!-- 
## articlesテーブル
## evaluationsテーブル
## likesテーブル
## personalテーブル

|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
|prefecture_id|integer|foreign_key: true|
|postcode|string||
|city|string||
|address|string||
|building|string||

### Association

- belongs_to :user
- belongs_to :prefecture
-->
