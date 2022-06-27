class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!, except: [:top,:about]

    
  def withdraw
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
    
  def show
      @customer = Customer.find(params[:id])
  end

  def edit
     @customer = Customer.find(params[:id])
    if @customer == current_customer
        render "edit"
    else
      redirect_to public_customer_path(@customer)
    end
    
  end
  def update
         @customer = Customer.find(params[:id])
     @customer.update(customer_params)
     if @customer.save
      redirect_to public_customer_path(), notice: "You have updated user successfully."
     else
      render "edit"
     end
  end
  def confirm

  end
  

  private

  def customer_params
    params.require(:customer).permit( :email, :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number)
  end

end
