class Item < ApplicationRecord
  belongs_to :category

  belongs_to :user

  #空の投稿を保存できないようにする
  validates :title, :text, presence: true

    #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1 } 
end
