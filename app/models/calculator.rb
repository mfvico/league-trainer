class Calculator

  require 'open-uri'

  def initialize(params)
    @raw_data = JSON.parse open('http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/item.json').read
    champion = JSON.parse open("http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion/#{params}.json").read
    @hp = champion["data"]["#{params}"]["stats"]["hp"]
  end

  def method_name

  end

end
