FactoryBot.define do
  factory :shipping_address do
    token           {"tok_abcdefghijk00000000000000000"}
    postal_code     {"123-4567"}
    prefecture_id   {Faker::Number.between(from: 2, to: 48)}
    city            {Faker::Address.city}
    address_detail  {Faker::Address.street_address}
    apartment_name  {"ABC Building"}
    phone_number    {Faker::Number.leading_zero_number(digits: 11)}
    user_id         {1}
    item_id         {1}
  end
end
