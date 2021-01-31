class AddressBuy
  
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address_detail, :apartment_name, :phone_number, :price, :user_id, :item_id, :token
  
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
   
  def save
    buy_histories = BuyHistory.create(user_id: user_id, item_id: item_id)
    # Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building_name: building_name, phone_number: phone_number, item_delivery_id: item_delivery.id)
  end
end