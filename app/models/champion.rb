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

  def initialize(champion)
    @champion = champion
    @raw_data = JSON.parse open("http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion/#{champion}.json").read
  end

  def stats_at_lvl1
    hash = {stats: {}}

    @raw_data["data"][@champion]["stats"].each do |key, value|
      hash[:stats][key.to_sym] = value
    end

    hash[:resource] = @raw_data["data"][@champion]["partype"]
    hash[:stats][:attackspeed] = (0.625/(1+hash[:stats][:attackspeedoffset])).round(3)
    hash
  end

  # level is 2 - 18
  # returns the stats that they have at that specific level
  # base value + increase value * growthstat
  def stats_per_level( level)
    champion_stats = stats_at_lvl1
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
