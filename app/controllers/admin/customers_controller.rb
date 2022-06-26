class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!, except: [:top,:about]
  
    def index
    @customers = Customer.all.page(params[:page]).per(10)
    @customer = current_customer
    end

  def show
    @customer = Customer.find(params[:id])
    
  end
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      if @customer.is_deleted == true
        @customer.update(is_deleted: false)
      else
        @customer.update(is_deleted: true)        
      end
      redirect_to admin_customer_path(@customer), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def edit
       @customer = Customer.find(params[:id])
  end
  
  private
  
  def customer_params
    params.require(:customer).permit( :email, :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number)
  end

  
end
