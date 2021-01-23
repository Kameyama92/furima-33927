# README


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
* has_many :buy_history



## items テーブル
| Column          | Type       | Options     |
| ----------------| ---------- | ----------- |
| item_name       | string     | null: false |
| detail          | text       | null: false |
| category_id     | integer    | null: false |
| condition_id    | integer    | null: false |
| delivery_fee    | integer    | null: false |
| shipping_area   | integer    | null: false |
| shipping_day    | integer    | null: false |
| buyer           | integer    | null: false |
| user            | references | null: false |

# Association
* belong_to :user
* has_one :buy_history

## shipping_address テーブル
| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| postal_code      | string     | null: false                   |
| prefectures_id   | integer    | null: false                   |
| city             | string     | null: false                   |
| address_detail   | string     | null: false                   |
| apartment_name   | string     |                               |
| phone_number     | string     | null: false                   |
| buy_history      | references | null：false、foreign_key：true |

# Association
* has_many :user


## buy_history テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

# Association
* belong_to :items
* belong_to :user
* has_one :shipping_address