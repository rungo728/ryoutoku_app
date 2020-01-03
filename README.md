# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Ryouoku_app
ご覧いただきましてありがとうございます。
<br>このアプリケーションは美味しいものを食べたくて料理はやってみたいけれど、敷居が高くてなかなかできない人向け
<br>料理も手軽に体験できて、食べられる体験シェアマッチングアプリです。

# DB設計

## ER図
<img width="1194" alt="スクリーンショット 2020-01-03 20.28.23" src="https://raw.githubusercontent.com/rungo728/ryoutoku_app/master/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202020-01-03%2020.28.23.png">

##  usersテーブル

|Column|Type|Options|
|------|----|-------|
|email|string|null: false,unique: true|
|name |string|null: false|
|password |string|null: false|
|profile|text||

<!-- 以下でaccepts_nested_attributes_forを定義し、親子関係のある関連モデルで、親モデル作成と同時に子モデルも作成する -->
### Association
- has_many :groups, through: :members
- has_many :members
- has_many :messages
- has_many :events
- has_many :comments
- has_many :cards
- has_many :evaluations
- has_many :events, through: :likes
- has_one:personal
- accepts_nested_attributes_for :personal
- belongs_to :phone
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

## phoneテーブル
|Column|Type|Options|
|------|----|-------|
|phone_number|string|null: false|


### Association

- belongs_to :user

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|event_id|integer|null: false, foreign_key: true|
|prefecture_id|integer|null: false, foreign_key: true|
|postcode|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|phone_number_sub|string||
|figure|text|null: false|


### Association

- belongs_to :event
- belongs_to :prefecture

## eventsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|description|text|null: false|
|status|string|null: false|
|capacity|string|null: false|
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
- has_many :comments
- has_many :images
- belongs_to :exhibitor
- has_many :users, through: :likes

## exhibitorsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|category_id|integer|null: false, foreign_key: true|
|event_id|integer|null: false, foreign_key: true|
|level1|string|null: false|
|level2|string|null: false|
|level3|string|null: false|
|level4|string|null: false|
|level5|string|null: false|

### Association
- has_many :events

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text||
|user_id|integer|null: false, foreign_key: true|
|event_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :event

## prefecturesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association

- has_many :users
- has_many :events
- has_many :personals
- has_many :addresses

## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|index?|

### Association

- has_many :items
- has_ancestry
- has_many :exhibitors

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|event_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :event

## membersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false,foreign_key: true|
|group_id|integer|null: false,foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|group_id|integer|null: false, foreign_key: true|
|user_id |integer|null: false, foreign_key: true|
|body|text|
|image|string|

### Association
- belongs_to :user
- belongs_to :group

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :users, through: groups_users
- has_many :groups_users
- has_many :messages

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
## likesテーブル -->