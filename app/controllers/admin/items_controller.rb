class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end
  
  def create
    item = Item.new(admin_item_params)
    item.save
    redirect_to admin_items_path
  end
  
  
  private
  def admin_item_params
    params.require(:item).permit(:genre_id, :name, :item_image, :introduction, :price, :is_active)
  end
  
  
end
