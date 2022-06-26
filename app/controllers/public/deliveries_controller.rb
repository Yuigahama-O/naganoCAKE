class Public::DeliveriesController < ApplicationController
      before_action :authenticate_customer!, except: [:top,:about]
  def index
    @delivery = current_customer.deliveries.new
    @deliveries = current_customer.deliveries.all
  end

  def edit
    @delivery = current_customer.deliveries.find(params[:id])
  end
  
  def create
    @delivery = current_customer.deliveries.new(delivery_params)
    @delivery.save
    redirect_to public_deliveries_path
  end
  
  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to public_deliveries_path
  end
  
  def update
    @delivery = current_customer.deliveries.find(params[:id])
    @delivery.update(delivery_params)
    redirect_to public_deliveries_path
  end
  
  private
  def delivery_params
    params.require(:delivery).permit(:customer_id, :postal_code, :address, :name)
  end
  
  
  
  
end