class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!, except: [:top,:about]

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "paid_up"

      @order.order_details.each do |o|
        o.update(making_status: "waiting_making")
      end
    end
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:status, :making_status)
  end
end
