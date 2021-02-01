class AddressBuy
  
  # ActiveModel::Modelを呼び出して、form_withメソッドに対応する機能とバリデーションを行う機能を持たせる
  include ActiveModel::Model

  # attr_accessorを用いて、保存したい複数のテーブルのカラム名すべてを扱えるようにしている
  attr_accessor :postal_code, :prefecture_id, :city, :address_detail, :apartment_name, :phone_number, :price, :user_id, :item_id, :token
  
  # バリデーションの処理
  with_options presence: true do
     validates :city
     validates :address_detail 
     validates :phone_number, length: { maximum: 11 }
     validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'Postal code Input correctly' }
     validates :token
     validates :item_id
     validates :user_id
   end

   validates :prefecture_id, numericality: { other_than: 1, message: 'Select' } 
   validates :phone_number, numericality: { only_integer: true, message: 'Input only number' }
   
  #  データをテーブルに保存する処理
  def save
    # 購入記録の情報を保存し、「buy_histories」という変数に入れている
    buy_histories = BuyHistory.create(user_id: user_id, item_id: item_id)
    # 住所の情報を保存
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_detail: address_detail, apartment_name: apartment_name, phone_number: phone_number, buy_history_id: buy_histories.id)
  end
end