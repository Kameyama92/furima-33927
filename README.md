# テーブル設計

## users テーブル
| Column             | Type   | Options                       |
| ------------------ | ------ | -----------                   |
| nickname           | string | null: false                   |
| email              | string | null: false, uniqueness: true |
| encrypted_password | string | null: false                   |
| last_name          | string | null: false                   |
| first_name         | string | null: false                   |
| kana_last_name     | string | null: false                   |
| kana_first_name    | string | null: false                   |
| birthdate          | date   | null: false                   |

# Association
* has_many :items
* has_many :sipping_address



## items テーブル
| Column          | Type    | Options     |
| ----------------| ------- | ----------- |
| item_name       | string  | null: false |
| detail          | text    | null: false |
| category        | string  | null: false |
| condition       | string  | null: false |
| delivery_fee    | string  | null: false |
| shipping_area   | string  | null: false |
| shipping_day    | integer | null: false |
| buyer           | string  | null: false |

# Association
* belong_to :user


## shipping_address テーブル
| Column           | Type     | Options       |
| ---------------- | -------- | ------------- |
| postal_code      | integer  | null: false   |
| prefectures      | string   | null: false   |
| city             | string   | null: false   |
| address_detail   | string   | null: false   |
| apartment_name   | string   | null: false   |
| phone_number     | string   | null: false   |

# Association
* belong_to :user


## buy_history テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |