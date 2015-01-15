class ItemsController < ApplicationController

  def index
    items = Item.new
    @item_list = items.item_list
  end



end
