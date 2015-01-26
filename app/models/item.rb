require 'open-uri'
require 'faraday'

class Item

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def item_list
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/item?api_key=#{ENV['PRIVATE_KEY']}"
    end
    raw_data = JSON.parse(response.body, symbolize_names: true)
  end

  def item_details(id)
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/item/#{id}?api_key=#{ENV['PRIVATE_KEY']}"
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
    conversion(raw_data)
  end

  private

  def conversion(input)
    input[:stats] ||= []
    doc = Nokogiri::HTML(input[:description].gsub('<br>', '||||'))
    array = doc.css('stats').text.split('||||')
    array.each do |stats|
      data = stats.split(' ')
      hash = Hash[data[1] => data[0]]
      input[:stats] << hash
    end
    input
  end



end
