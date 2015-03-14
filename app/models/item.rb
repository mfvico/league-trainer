require 'open-uri'
require 'faraday'

class Item

  ITEM_STATS = {
    "Health" => :FlatHPPoolMod,
    "Bonus Health" => :PercentHPPoolMod,
    "Base Health Regen" => :FlatHPRegenMod,
    "Life Steal" => :PercentLifeStealMod,
    "Mana" => :FlatMPPoolMod,
    "Base Mana Regen" => :FlatMPRegenMod,
    "Critical Strike Chance"=> :FlatCritChanceMod,
    "Attack Damage" => :FlatPhysicalDamageMod,
    "Ability Power" => :FlatMagicDamageMod,
    "Movement Speed" => :FlatMovementSpeedMod,
    "Magic Resist" => :FlatSpellBlockMod,
    "Armor" => :FlatArmorMod,
  }

  def initialize
    @conn = Faraday.new(:url => 'https://na.api.pvp.net')
  end

  def item_list
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/item"
      req.params['api_key'] = ENV['PRIVATE_KEY']
    end
    raw_data = JSON.parse(response.body, symbolize_names: true)
  end

  def item_details(id)
    response = @conn.get do |req|
      req.url "/api/lol/static-data/na/v1.2/item/#{id}"
      req.params['api_key'] = ENV['PRIVATE_KEY']
      req.params['itemData'] = 'all'
    end
    raw_data =  JSON.parse(response.body, symbolize_names: true)
    unique_abilites(raw_data)
    weird_stats(raw_data)
  end

  private

  def unique_abilites(input)
    input[:passive] ||= []
    unique_doc = Nokogiri::HTML(input[:description])
    unique_desc = unique_doc.css('body').text.split('UNIQUE Passive')
    unique_desc = unique_desc[1..unique_desc.length-1]
    unique_desc.each do |u|
      hash = {}
      array = u.split(' - ')[-1]
      if array.match(/(UNIQUE Active)/)
        active_hash = {}
        active_array = array.split('UNIQUE Active')[-1].split(': ')
        active_hash[active_array[0]] = active_array[1]
        input[:active] = active_hash
      end
      passive_array  = array.split('UNIQUE Active')[0].split(': ')
      hash[passive_array[0]] = passive_array[1]
      input[:passive] << hash
    end
    input
  end

  def weird_stats(input)
    unique_hash = {}
    stat_doc = Nokogiri::HTML(input[:description].gsub('<br>', '++++'))
    stat_doc = stat_doc.css('stats').text.split('++++')
    stat_doc.each do |value|
      value = value.split(' ')

      stat_value = value[0]
      stat_name = value[1..value.length-1].join(' ').split(" (")[0]
      input[:stats][ITEM_STATS[stat_name]] ||= stat_value
    end
    input
  end

  # Item.new.item_details(3153)


end
