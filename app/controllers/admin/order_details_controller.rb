class Admin::OrderDetailsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == "making"
      @order_detail.order.update(status: "cooking")

    elsif @order.order_details.where(making_status: 3).count == @order.order_details.count
      @order_detail.order.update(status: "preparing")
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
