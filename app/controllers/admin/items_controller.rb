class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(admin_item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  def create
    @item = Item.new(admin_item_params)
    @item.save
    redirect_to admin_items_path
  end
  
  
  private
  def admin_item_params
    params.require(:item).permit(:genre_id, :name, :item_image, :introduction, :price, :is_active)
  end
  
  
end
