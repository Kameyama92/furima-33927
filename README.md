# README

application up and running.
## users テーブル
| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| nickname           | string | null: false                   |
| email              | string | null: false, unique:true      |
| encrypted_password | string | null: false                   |
| last_name          | string | null: false                   |
| first_name         | string | null: false                   |
| kana_last_name     | string | null: false                   |
| kana_first_name    | string | null: false                   |
| birthday           | date   | null: false                   |

# Association
* has_many :items
* has_many :buy_histories



## items テーブル
| Column           | Type       | Options                        |
| -----------------| ---------- | ------------------------------ |
| item_name        | string     | null: false                    |
| detail           | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| delivery_fee_id  | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_day_id  | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

# Association
* belongs_to :user
* has_one :buy_history

## shipping_addresses テーブル
| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| postal_code      | string     | null: false                   |
| prefecture_id    | integer    | null: false                   |
| city             | string     | null: false                   |
| address_detail   | string     | null: false                   |
| apartment_name   | string     |                               |
| phone_number     | string     | null: false                   |
| buy_history      | references | null：false、foreign_key：true |

# Association
* belongs_to :buy_history


## buy_histories テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

# Association
* belongs_to :item
* belongs_to :user
* has_one :shipping_address
