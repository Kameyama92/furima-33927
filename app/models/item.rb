class Item < ApplicationRecord

  belongs_to :user
  has_one :buy_history
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_day
  



  #空の投稿を保存できないようにする
  with_options presence: true do
    validates :image
    validates :item_name
    validates :detail
    validates :price
  end

  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000, message: "上記の販売価格を半角数字で入力してください"}

    #ジャンルの選択が「--」の時は保存できない
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :delivery_fee_id
      validates :prefecture_id
      validates :shipping_day_id
    end
end