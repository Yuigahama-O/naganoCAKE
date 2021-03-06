class Public::CartItemsController < ApplicationController
      before_action :authenticate_customer!, except: [:top,:about]
  def index
    @cart_items = current_customer.cart_items
    @sum
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def create
    if @cart_item = CartItem.find_by(item_id: cart_item_params[:item_id])
      @cart_item.customer_id = current_customer.id

      @add_amount = @cart_item.amount + (params[:cart_item][:amount]).to_i
      @cart_item.update(amount: @add_amount)

    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    end
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end



end
