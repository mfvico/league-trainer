class LeagueAPI

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def champions

      response = @conn.get do |req|
        req.url "/api/lol/na/v1.2/champion"
        # req.headers['Content-Type'] = 'application/json'
        req.params['api_key'] = ENV["PRIVATE_KEY"]
      end
      JSON.parse(response.body, symbolize_names: true)

  end

end
