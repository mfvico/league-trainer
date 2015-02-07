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
      req.url "/api/lol/static-data/na/v1.2/item/#{id}?itemData=all&api_key=#{ENV['PRIVATE_KEY']}"
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

  private

  # def conversion(input)
  #   input[:stats] ||= []
  #   input[:unique] ||= []
  #   stats_doc = Nokogiri::HTML(input[:description].gsub('<br>', '||||'))
  #   unique_doc = Nokogiri::HTML(input[:description].gsub('</stats>', '||||'))
  #   stats_array = stats_doc.css('stats').text.split('||||')
  #   unique_array = unique_doc.text.split("||||")
  #   unique = unique_array.pop
  #   input[:unique] << unique
  #   stats_array.each do |stats|
  #     stats_data = stats.split(' ')
  #     stats_hash = Hash[stats_data[1].to_sym => stats_data[0].to_i]
  #     input[:stats] << stats_hash
  #   end
  #   input
  # end



end
