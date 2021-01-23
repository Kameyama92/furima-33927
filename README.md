# テーブル設計

## users テーブル
| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| kana_last_name  | string | null: false |
| kana_first_name | string | null: false |
| birthdate       | string | null: false |


## items テーブル
| Column          | Type   | Options     |
| ----------------| ------ | ----------- |
| item_name       | string | null: false |
| detail          | text   | null: false |
| category        | string | null: false |
| condition       | string | null: false |
| delivery_fee    | string | null: false |
| shipping_area   | string | null: false |
| Shipping_days   | string | null: false |
| buyer           | string | null: false |


## shipping_address テーブル
| Column           | Type     | Options       |
| ---------------- | -------- | ------------- |
| credit           | string   | null: false   |
| expiration_date  | string   | null: false   |
| security         | string   | null: false   |
| postal_code      | integer  | null: false   |
| prefectures      | string   | null: false   |
| city             | string   | null: false   |
| address_detail   | string   | null: false   |
| apartment_name   | string   | null: false   |
| phone_number     | string   | null: false   |


## buy_history テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |