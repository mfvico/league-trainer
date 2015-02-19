class Summoner

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def summoner_id(summoner)
    response = @conn.get do |req|
      req.url "api/lol/na/v1.4/summoner/by-name/#{summoner}"
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

  def game_history(summoner)
    response = @conn.get do |req|
      req.url "/api/lol/na/v1.3/game/by-summoner/#{summoner}/recent"
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

  def summoner_runes(summoner)
    response = @conn.get do |req|
      req.url "api/lol/na/v1.4/summoner/#{summoner}/runes"
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

  def summoner_masteries(summoner)
    response = @conn.get do |req|
      req.url "api/lol/na/v1.4/summoner/#{summoner}/masteries"
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

end
