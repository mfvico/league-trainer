class Rune

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def rune_list
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/rune"
      req.params['runeListData'] = 'basic'
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

  def rune_data(info, rune)
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/rune/#{rune}"
      req.params['runeData'] = info
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

end
