class Calculator

  require 'open-uri'

  def initialize(champion)
    @champion = Champion.new.stats_per_level(champion, 18)
    @item_list = Item.new.item_list
  end

  def data_calculation(item_array)
    items = item_compiler(item_array)
    @champion[:stats_with_items] = @champion[:stats]


  end

  private

  def item_compiler(item_id_array)


    item_array = []

    item_id_array.each do |item|
      item_stats = Item.new.item_details(item)
      item_array << item_stats
    end
    item_array
  end

end
