class Calculator

  require 'open-uri'

  MATH_PROCS = {
    add: Proc.new {|stat, increase| stat + increase},
    percent: Proc.new {|stat, increase| (stat * (1+increase)).round(3)}
  }

  ITEM_ATTRS = {
    FlatArmorMod: {stat: :armor, math: :add},
    PercentAttackSpeedMod:{stat: :attackspeed, math: :percent},
    PercentMovementSpeedMod:{stat: :movespeed, math: :percent},
    FlatCritChanceMod:{stat: :crit, math: :add},
    FlatHPPoolMod:{stat: :hp, math: :add},
    FlatMagicDamageMod:{stat: :ap, math: :add},
    FlatPhysicalDamageMod:{stat: :attackdamage, math: :add},
    FlatMPPoolMod: {stat: :mp, math: :add},
    FlatSpellBlockMod:{stat: :spellblock, math: :add},
  }

  def initialize(champion)
    @champion = Champion.new.stats_per_level('stats', champion, 18)
    @item_list = Item.new.item_list
  end

  def data_calculation(item_array)
    items = item_compiler(item_array)
    @champion[:stats_with_items] = @champion[:stats]
    @champion[:stats_with_items][:ap] = 0

    items.each do |item|
      item[:stats].each do |stat_key, stat_value|
        item_attrs = ITEM_ATTRS[stat_key]
        champ_stat = @champion[:stats_with_items][item_attrs[:stat]]

        math_key = item_attrs[:math]
        new_value = MATH_PROCS[math_key].call(champ_stat, stat_value)

        @champion[:stats_with_items][item_attrs[:stat]] = new_value
      end
    end

    @champion
  end

  private

  def item_compiler(item_id_array)
    item_array = []

    item_id_array.each do |item|
      item_stats = Item.new.item_details(item)
      item_array << item_stats
    end
    item_array
  end

end
