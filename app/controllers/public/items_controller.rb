class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


  private
  def public_item_params
    params.require(:item).permit(:genre_id, :name, :item_image, :introduction, :price, :is_active)
  end
end
