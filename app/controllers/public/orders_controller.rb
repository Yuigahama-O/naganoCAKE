class Public::OrdersController < ApplicationController


  def new
    @order = current_customer.orders.new
  end

  def index
  end

  def show
  end

  def comfirm
    @order = Order.new(order_params)


    if params[:order][:address_option] == "my_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.save
      redirect_to public_order_path(@order)
    elsif params[:order][:address_option] == "choose_address"
      address = current_customer.deliveries.find(params[:order][:delivery_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
      @order.save
      redirect_to public_order_path(@order)
    else
      @order.invalid?
      render 'new'
    end

  end

  def create

  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address)
  end
end
