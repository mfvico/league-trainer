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

  def rune_page(summoner_id, page_id)
    user_pages = rune_pages(summoner_id)
    user_pages.each do |id, pages|
      pages[:pages].each do |page|
        if page[:id] == page_id
          @rune_page = page
        end
      end
    end
    rune_count(@rune_page)
    rune_compiling(@rune_hash)
    @rune_hash
  end


  def rune_pages(summoner_id)
    @rune_pages = Summoner.new.summoner_runes(summoner_id)
  end

  private

  def rune_count(rune_page)
    @rune_hash = {}
    rune_page[:slots].each do |slot|
      @rune_hash[slot[:runeId]] ||= {}
      @rune_hash[slot[:runeId]][:count] ||=0
      @rune_hash[slot[:runeId]][:count] += 1
    end
  end

  def rune_compiling(rune_hash)
    rune_hash.each do |id, stats|
      stats[:stats] = Rune.new.rune_data('stats', id)
    end
  end

end
