class Calculator

  require 'open-uri'

  def initialize
    @raw_data = JSON.parse open('http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/item.json').read
  end

  


end
