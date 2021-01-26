FactoryBot.define do
  factory :item do
    item_name                       {Faker::Lorem.sentence}
    detail                          {Faker::Lorem.sentence}
    category_id                     {3}
    price                           {777}
    condition_id                    {3}
    delivery_fee_id                 {3}
    prefecture_id                   {3}
    shipping_day_id                 {3}
    association                     :user
  
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'text_image.png')
    end
    
  end
end
