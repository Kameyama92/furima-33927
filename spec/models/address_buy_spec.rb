require 'rails_helper'

RSpec.describe AddressBuy, type: :model do

  before do
    @address_buy = FactoryBot.build(:address_buy)
  end

  describe "商品の購入" do

    context "購入できる" do
      it "十分な値が入力された場合購入できる" do
        expect(@address_buy).to be_valid
      end

      it "建物名が空でも購入できる" do
        @address_buy.apartment_name = ""
        expect(@address_buy).to be_valid
      end
    end

    context "購入できない" do
      it "クレジットカード情報が空では購入できないこと" do
        @address_buy.token = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Token can't be blank")
      end

      it "郵便番号が空では購入できない" do
        @address_buy.postal_code = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Postal code can't be blank", "Postal code Postal code Input correctly")
      end

      it "郵便番号にハイフンがなければ購入できない" do
        @address_buy.postal_code = "12345567"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Postal code Postal code Input correctly")
      end

      it "郵便番号が全角数字の場合購入できない" do
        @address_buy.postal_code = "１２３−４５６７"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Postal code Postal code Input correctly")
      end

      it "都道府県が空では購入できない" do
        @address_buy.prefecture_id = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Prefecture Select")
      end

      it "都道府県が未選択だと購入できない" do
        @address_buy.prefecture_id = 1
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Prefecture Select")
      end

      it "市区町村が空では購入できない" do
        @address_buy.city = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("City can't be blank")
      end

      it "番地が空では購入できない" do
        @address_buy.address_detail = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Address detail can't be blank")
      end

      it "電話番号が空では購入できない" do
        @address_buy.phone_number = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Phone number can't be blank", "Phone number Input only number")
      end

      it "電話番号が全角数字では購入できない" do
        @address_buy.phone_number = "０９０１２３４５６７８"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Phone number Input only number")
      end

      it "電話番号が数字のみでないと購入できない" do
        @address_buy.phone_number = "abc12345678"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Phone number Input only number")
      end

      it "電話番号が11桁以内でないと購入できない" do
        @address_buy.phone_number = "090123456789"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end

      it "user_idが空だと購入できない" do
        @address_buy.user_id = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("User can't be blank")
      end

      it "item_idが空だと購入できない" do
        @address_buy.item_id = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
  