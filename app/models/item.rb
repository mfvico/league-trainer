require 'open-uri'

class Item

  def initialize
    @raw_data = JSON.parse open('http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/item.json').read
  end

  def item_list
    hash = {}
    @raw_data["data"].each do |key, value|
      hash[key.to_sym] = value
    end
    hash
  end

end
