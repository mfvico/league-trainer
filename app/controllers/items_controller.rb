class ItemsController < ApplicationController

  def index
    items = Item.new
    @item_list = items.item_list
  end

  def show
    items = Item.new
    @item_details = items.item_details(params[:id])
  end

end
