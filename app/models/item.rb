require 'open-uri'
require 'faraday'

class Item

  ITEM_STATS = {
    "Mana" => :mana
  }

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def item_list
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/item"
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data = JSON.parse(response.body, symbolize_names: true)
  end

  def item_details(id)
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/item/#{id}"
      req.params['api_key'] = ENV['PRIVATE_KEY']
      req.params['itemData'] = 'all'
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
    unique_abilites(raw_data)
    weird_stats(raw_data)
  end

  private

  def unique_abilites(input)
    unique_hash = {}
    input[:unique] ||= []
    unique_doc = Nokogiri::HTML(input[:description].gsub('</stats>', '||||'))
    unique_array = unique_doc.text.split("||||")[1].split('UNIQUE Passive - ').reject! {|u| u.empty?}
    unique_array.each do |u|
      unique_name = u.split(': ')[0]
      unique_description = u.split(': ')[1]
      unique_hash[unique_name.to_sym] = unique_description
      input[:unique] << unique_hash
    end
    input
  end

  def weird_stats(input)
    unique_hash = {}
    unique_doc = Nokogiri::HTML(input[:description].gsub('</stats>','||||').gsub('<br>', '++++'))
    stat_array = unique_doc.text.split("||||")
    stat_array[0].split("++++").each do |stats|
      setup = stats.split(' ')
      input[:stats][ITEM_STATS[stats[1]]] ||= stats[0]
      binding.pry
    end

  end



end
