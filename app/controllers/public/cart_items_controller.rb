class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @sum
  end

  def update
    cart_item = CartItems.find(params[:id])
    cart_item.update
    redirect_to public_cart_items_path
  end

  def create
    item = Item.find(cart_item_params[:item_id])
    item.save
    redirect_to public_cart_items_path
  end

  def destroy
    item = Item.find(cart_item_params[:item_id])
    item.destroy
  end

  def destroy_all
    CartItems.destroy_all
    redirect_to public_cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
