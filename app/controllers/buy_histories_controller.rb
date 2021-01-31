class BuyHistoriesController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    # @user_ =   
  end

end
