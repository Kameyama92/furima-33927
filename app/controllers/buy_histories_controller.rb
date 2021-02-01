class BuyHistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :address_params]

  def index
    @address_buy = AddressBuy.new
    if current_user.id == @item.user_id || @item.buy_history.present?
      redirect_to root_path
    end
  end

  def create
      @address_buy = AddressBuy.new(address_params)
    if @address_buy.valid?
      pay_item
      @address_buy.save
      return redirect_to root_path
    else
      render :index 
    end
  end

  private

  def address_params
    params.require(:address_buy).permit(:postal_code, :prefecture_id, :city, :address_detail, :apartment_name, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,              # 商品の値段
      card: address_params[:token],    # カードトークン
      currency: 'jpy'                   # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
