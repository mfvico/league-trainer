class Champion

  def initialize(champion)
    @raw_data = JSON.parse open("http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion/#{champion}.json").read

  end

  def stats_at_lvl1(champion)
    hash = {}
    hash[:hp] = @raw_data["data"]["#{champion}"]["stats"]["hp"] *1000.to_i
    hash[:hpprelevel] =@raw_data["data"]["#{champion}"]["stats"]["hpperlevel"]*1000.to_i
    hash[:hpregen] =@raw_data["data"]["#{champion}"]["stats"]["hpregen"]*1000.to_i
    hash[:hpregenperlevel] =@raw_data["data"]["#{champion}"]["stats"]["hpregenperlevel"]*1000.to_i
    hash[:resource] = @raw_data["data"]["#{champion}"]["partype"]*1000.to_i
    hash[:mp] = @raw_data["data"]["#{champion}"]["stats"]["mp"]*1000.to_i
    hash[:mpregen] = @raw_data["data"]["#{champion}"]["stats"]["mpregen"]*1000.to_i
    hash[:mpperlevel] = @raw_data["data"]["#{champion}"]["stats"]["mpperlevel"]*1000.to_i
    hash[:movespeed] = @raw_data["data"]["#{champion}"]["stats"]["movespeed"]*1000.to_i
    hash[:armor] = @raw_data["data"]["#{champion}"]["stats"]["armor"]*1000.to_i
    hash[:armorperlevel] = @raw_data["data"]["#{champion}"]["stats"]["armorperlevel"]*1000.to_i
    hash[:spellblock] = @raw_data["data"]["#{champion}"]["stats"]["spellblock"]*1000.to_i
    hash[:spellblockperlevel] = @raw_data["data"]["#{champion}"]["stats"]["spellblockperlevel"]*1000.to_i
    hash[:attackdamage] = @raw_data["data"]["#{champion}"]["stats"]["attackdamage"]*1000.to_i
    hash[:attackdamageperlevel] = @raw_data["data"]["#{champion}"]["stats"]["attackdamageperlevel"]*1000.to_i
    return hash
  end


end
