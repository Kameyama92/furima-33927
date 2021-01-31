require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do

  before do
    @address_buy = FactoryBot.build(:shipping_address)
  end

  describe "商品の購入" do

    context "購入できる" do
      it "十分な値が入力された場合購入できる" do
        expect(@address_buy).to be_valid
      end

      it "建物名が空でも購入できる" do
        @address_buy.building = ""
        expect().to be_valid
      end
    end

    context "購入できない" do
      it "クレジットカード情報が空では購入できないこと" do
        @address_buy.token = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("クレジットカード情報を入力してください")
      end

      it "郵便番号が空では購入できない" do
        @address_buy.pos_code = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("郵便番号を入力してください")
      end

      it "郵便番号にハイフンがなければ購入できない" do
        @address_buy.postal_code = 12345567
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("郵便番号は半角数字で-(ハイフン)を含めて入力してください")
      end

      it "郵便番号が全角数字の場合購入できない" do
        @address_buy.postal_code = "１２３−４５６７"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("郵便番号は半角数字で-(ハイフン)を含めて入力してください")
      end

      it "都道府県が空では購入できない" do
        @address_buy.prefecture_id = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("都道府県を入力してください")
      end

      it "都道府県が未選択だと購入できない" do
        @address_buy.prefecture_id = 1
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("都道府県を選択してください")
      end

      it "市区町村が空では購入できない" do
        @address_buy.city = ""
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("市区町村を入力してください")
      end

      it "番地が空では購入できない" do
        @address_buy.address_detail = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("番地を入力してください")
      end

      it "電話番号が空では購入できない" do
        @address_buy.phone_number = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("電話番号を入力してください")
      end

      it "電話番号が全角数字では購入できない" do
        @address_buy.phone_number = "０９０１２３４５６７８"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("電話番号は半角数字で入力してください")
      end

      it "電話番号が数字のみでないと購入できない" do
        @address_buy.phone_number = "abc12345678"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include()
      end

      it "電話番号が11桁以内でないと購入できない" do
        @address_buy.phone_number = "090123456789"
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include()
      end

      it "user_idが空だと購入できない" do
        @address_buy.user_id = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Userを入力してください")
      end

      it "item_idが空だと購入できない" do
        @address_buy.item_id = nil
        @address_buy.valid?
        expect(@address_buy.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
  