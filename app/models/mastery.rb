class Mastery

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def mastery_list
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/mastery"
      req.params['masteryListData'] = 'all'
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

  def mastery_data(info, mastery)
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/mastery/#{mastery}"
      req.params['masteryData'] = info
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

end
