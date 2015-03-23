require 'open-uri'

class Champion

  CHAMPION_ATTRS = [
    :hp,
    :mp,
    :armor,
    :spellblock,
    :hpregen,
    :mpregen,
    :crit,
    :attackdamage,
    :attackspeed,
  ]

  CHAMPION_INCREASES = {
    mp: :mpperlevel,
    hp: :hpperlevel,
    armor: :armorperlevel,
    spellblock: :spellblockperlevel,
    hpregen: :hpregenperlevel,
    mpregen: :mpregenperlevel,
    crit: :critperlevel,
    attackdamage: :attackdamageperlevel,
    attackspeed: :attackspeedperlevel
  }

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def champion_list(info)
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/champion"
      info.each do |i|
        req.params['champData'] ||= ''
        req.params['champData'] += i + ','
      end
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
  end

  def champion_info(info, champion)
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/champion/#{champion}"
      req.params['champData'] = ''
      info.each do |i|
        req.params['champData'] += i + ","
      end
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    champion_info =  JSON.parse(response.body, symbolize_names: true)
    champion_info[:stats][:attackspeed] = (0.625/(1+champion_info[:stats][:attackspeedoffset])).round(3)
    champion_info
  end

  # level is 2 - 18
  # returns the stats that they have at that specific level
  # base value + increase value * growthstat
  def stats_per_level(info, champion, level)
    champion_stats = champion_info(info, champion)
    2.upto(level) do |i|
      CHAMPION_ATTRS.each do |key|
        if CHAMPION_INCREASES[key]
          increase_per_level = champion_stats[:stats][CHAMPION_INCREASES[key]]
          if key == :attackspeed
            base_atkspd = champion_stats[:stats][key]
            champion_stats[:stats][key] += base_atkspd * (increase_per_level * (((i * 3.5)+ 65)/100)/100)
          else
            champion_stats[:stats][key] += increase_per_level * (((i * 3.5) + 65)/100)
          end
          champion_stats[:stats][key] = champion_stats[:stats][key].round(3)
        end
      end
    end
    champion_stats
  end

end
