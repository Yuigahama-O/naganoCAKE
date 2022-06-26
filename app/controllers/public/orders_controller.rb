class Public::OrdersController < ApplicationController
    before_action :authenticate_customer!, except: [:top,:about]

  def new
    @order = current_customer.orders.new
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
  end



  def confirm
    @order = current_customer.orders.new(order_params)


    if params[:order][:address_option] == "my_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_option] == "choose_address"

      delivery = current_customer.deliveries.find(params[:order][:delivery])
      @order.postal_code = delivery.postal_code
      @order.address = delivery.address
      @order.name = delivery.name

    else
      if @order.invalid?
        flash[:notice] = "入力してください"
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
    @order.shipping_cost = 800
    @order.save

    current_customer.cart_items.each do |c|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = c.item_id
      @order_detail.amount = c.amount
      @order_detail.price = c.item.with_tax_price
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to public_orders_complete_path
  end


  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address, :total_payment)
  end
end
