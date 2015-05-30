class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = Item.all
    render json: @items
  end

  def show
    render json: @item
  end

  def create
    @item = Item.new(item_params)
    
    if @item.save
      render json: { success: true, item: @item }
    else
      render json: { success: false, errors: @item.errors }
    end
    
  end

  def update
    if @item.update(item_params)
      render json: { success: true, item: @item }
    else
      render json: { success: false, errors: @item.errors }
    end
  end

  def destroy
    @item.destroy
    render json: { success: true }
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :price)
    end
    
end
