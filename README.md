# README

# Ryouoku_app
ご覧いただきましてありがとうございます。
<br>このアプリケーションは美味しいものを食べたくて料理はやってみたいけれど、敷居が高くてなかなかできない人向け
<br>料理も手軽に体験できて、食べられる体験シェアマッチングアプリです。

url:http://13.230.196.160:3000/

* Basic認証
<br>ID: 
<br>Password: 

# 開発メンバー
* 小山薫

# 制作環境
* Ruby on Rails '5.2.3'
* mysql2 '>= 0.4.4', '< 0.6.0'
* AWS、S3を用いたデプロイと画像の保存。


# 使い方

# 工夫した点

# 改善点

# DB設計

## ER図
<img width="1194" alt="スクリーンショット 2020-01-03 20.28.23" src="https://github.com/rungo728/ryoutoku_app/blob/master/app/assets/images/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202020-01-03%2020.28.23.png">

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
<!-- 余裕があればgooglemapが表示できるようにしたい↓ -->
|figure|text|null: false|


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
|buyer_id|integer|null: false, foreign_key: true|
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
Column|Type|Options|
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
-->