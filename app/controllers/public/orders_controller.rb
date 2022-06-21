class Public::OrdersController < ApplicationController


  def new
    @order = current_customer.orders.new
  end

  def index
  end

  def show
  end



  def confirm
    @order = Order.new(order_params)


    if params[:order][:address_option] == "my_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_option] == "choose_address"
      delivery = current_customer.deliveries.find(params[:order][:delivery_id])
      @order.postal_code = delivery.postal_code
      @order.address = delivery.address
      @order.name = delivery.name

    else
      if @order.invalid?
        render 'new'
      else
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      end

    end
    @sum
    @cart_items = current_customer.cart_items.all
    @payment_method = params[:order][:payment_method]
    @address_option = params[:order][:address_option]


  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save

    current_customer.cart_items.each do |c|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = c.item_id
      @order_detail.amount = c.amount
      @order_detail.price = c.item.price
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to public_orders_complete_path
  end


  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address)
  end
end
