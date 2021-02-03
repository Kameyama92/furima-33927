class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]


  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  
  end

  def edit
    if @item.buy_history.present?
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :item_name, :detail, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    @item = Item.find(params[:id])
    unless @item.user.id == current_user.id
      redirect_to root_path
    end
  end

end
