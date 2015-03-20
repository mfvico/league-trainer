class Calculator

  MATH_PROCS = {
    add: ->(stat, increase) { stat + increase },
    percent: ->(stat, increase) { (stat * (1+increase)).round(3) },
    add_per_level: ->(stat, increase, level) { stat + (increase * level) },
    percent_per_level: ->(stat, increase, level) {(stat * (1 + (increase*level))).round(3)},
    block_add: -> (stat_array, increase) {stat_array.each do |stat|
      stat + increase
    end
    }
  }

  RUNE_FLAT_ATTRS = {
    FlatArmorMod: {stat: :armor, math: MATH_PROCS[:add]},
    rFlatArmorPenetrationMod: {stat: :armorpen, math: MATH_PROCS[:add]},
    FlatBlockMod: {stat: :spellblock, math: MATH_PROCS[:block_add]}, #do for both armor and mr
    FlatCritChanceMod: {stat: :crit, math: MATH_PROCS[:add]},
    FlatCritDamageMod: {stat: :critdamage, math: MATH_PROCS[:add]},
    FlatEnergyPoolMod: {stat: :mp, math: MATH_PROCS[:add]},
    FlatEnergyRegenMod: {stat: :manaregen, math: MATH_PROCS[:add]},
    FlatHPPoolMod: {stat: :hp, math: MATH_PROCS[:add]},
    FlatHPRegenMod: {stat: :hpregen, math: MATH_PROCS[:add]},
    FlatMPPoolMod: {stat: :mp, math: MATH_PROCS[:add]},
    FlatMPRegenMod: {stat: :mpregen, math: MATH_PROCS[:add]},
    FlatMagicDamageMod: {stat: :ap, math: MATH_PROCS[:add]},
    FlatPhysicalDamageMod: {stat: :attackdamage, math: MATH_PROCS[:add]},
    FlatSpellBlockMod: {stat: :spellblock, math: MATH_PROCS[:add]},
    rFlatMagicPenetrationMod: {stat: :magicpen, math: MATH_PROCS[:add]},
    rPercentCooldownMod: {stat: :cooldown, math: MATH_PROCS[:add]},
    rPercentTimeDeadMod: {stat: :deathtimer, math: MATH_PROCS[:add]},
  }
  RUNE_PERCENT_ATTRS = {
    PercentArmorMod: {stat: :armor, math: MATH_PROCS[:percent]},
    PercentAttackSpeedMod: {stat: :attackspeed, math: MATH_PROCS[:percent]},
    PercentBlockMod: {stat: [:armor, :spellblock], math: MATH_PROCS[:block_percent]}, #do for both armor and mr
    PercentCritChanceMod: {stat: :crit, math: MATH_PROCS[:percent]},
    PercentCritDamageMod: {stat: :critdamage, math: MATH_PROCS[:percent]},
    PercentEXPBonus: {stat: :exp, math: MATH_PROCS[:add]},
    PercentHPPoolMod: {stat: :hp, math: MATH_PROCS[:percent]},
    PercentHPRegenMod: {stat: :hpregen, math: MATH_PROCS[:percent]},
    PercentLifestealMod: {stat: :lifesteal, math: MATH_PROCS[:add]},
    PercentMPPoolMod: {stat: :mp, math: MATH_PROCS[:percent]},
    PercentMPRegenMod: {stat: :mpregen, math: MATH_PROCS[:percent]},
    PercentMagicDamageMod: {stat: :ap, math: MATH_PROCS[:percent]},
    PercentMovementSpeedMod: {stat: :movespeed, math: MATH_PROCS[:percent]},
    PercentPhysicalDamageMod: {stat: :attackdamage, math: MATH_PROCS[:percent]},
    PercentSpellBlockMod: {stat: :spellblock, math: MATH_PROCS[:percent]},
    PercentSpellVampMod: {stat: :spellvamp, math: MATH_PROCS[:percent]},
    rPercentMagicPenetrationMod: {stat: :magicpen, math: MATH_PROCS[:percent]},
  }
  RUNE_FLAT_PER_LVL_ATTRS = {
    rFlatArmorModPerLevel: {stat: :armor, math: MATH_PROCS[:add_per_level]},
    rFlatArmorModPerLevel: {stat: :armor, math: MATH_PROCS[:add_per_level]},
    rFlatEnergyModPerLevel: {stat: :mp, math: MATH_PROCS[:add_per_level]},
    rFlatEnergyRegenModPerLevel: {stat: :mpregen, math: MATH_PROCS[:add_per_level]},
    rFlatGoldPer10Mod: {stat: :goldper10, math: MATH_PROCS[:add_per_level]},
    rFlatHPModPerLevel: {stat: :hp, math: MATH_PROCS[:add_per_level]},
    rFlatHPRegenModPerLevel: {stat: :hpregen, math: MATH_PROCS[:add_per_level]},
    rFlatMPModPerLevel: {stat: :mp, math: MATH_PROCS[:add_per_level]},
    rFlatMPRegenModPerLevel: {stat: :mpregen, math: MATH_PROCS[:add_per_level]},
    rFlatMagicDamageModPerLevel: {stat: :ap, math: MATH_PROCS[:add_per_level]},
    rFlatPhysicalDamageModPerLevel: {stat: :attackdamage, math: MATH_PROCS[:add_per_level]},
    rFlatSpellBlockModPerLevel: {stat: :spellblock, math: MATH_PROCS[:add_per_level]},
    rPercentCooldownModPerLevel: {stat: :cooldown, math: MATH_PROCS[:add_per_level]},
  }

  RUNE_PERCENT_PER_LEVEL_ATTRS = {
    rPercentAttackSpeedModPerLevel: {stat: :attackspeed, math: MATH_PROCS[:percent_per_level]},
  }

  ITEM_ATTRS = {
    FlatArmorMod: {stat: :armor, math: MATH_PROCS[:add]},
    PercentAttackSpeedMod:{stat: :attackspeed, math: MATH_PROCS[:percent]},
    PercentMovementSpeedMod:{stat: :movespeed, math: MATH_PROCS[:percent]},
    PercentLifeStealMod:{stat: :lifesteal, math: MATH_PROCS[:add]},
    FlatMovementSpeedMod:{stat: :movespeed, math: MATH_PROCS[:add]},
    FlatCritChanceMod:{stat: :crit, math: MATH_PROCS[:add]},
    FlatHPPoolMod:{stat: :hp, math: MATH_PROCS[:add]},
    FlatMagicDamageMod:{stat: :ap, math: MATH_PROCS[:add]},
    FlatPhysicalDamageMod:{stat: :attackdamage, math: MATH_PROCS[:add]},
    FlatMPPoolMod: {stat: :mp, math: MATH_PROCS[:add]},
    FlatSpellBlockMod:{stat: :spellblock, math: MATH_PROCS[:add]},
  }

  def initialize(champion)
    @champion = Champion.new.stats_per_level(['stats', 'partype'], champion, 18)
    @item_list = Item.new.item_list
  end

  def item_calculation(item_array)
    items = item_compiler(item_array)
    @champion[:stats_with_items] = @champion[:stats]
    @champion[:stats_with_items][:ap] = 0
    @champion[:stats_with_items][:lifesteal] = 0

    items.each do |item|
      item[:stats].each do |stat_key, stat_value|
        item_attrs = ITEM_ATTRS[stat_key]
        champ_stat = @champion[:stats_with_items][item_attrs[:stat]]

        new_value = (item_attrs[:math].call(champ_stat, stat_value)).round(3)

        @champion[:stats_with_items][item_attrs[:stat]] = new_value
      end
    end

    @champion
  end

  def item_array(id_array)
    item_compiler(id_array)
  end

  private

  def item_compiler(id_array)
    item_array = []

    id_array.each do |item|
      item_stats = Item.new.item_details(item)
      item_array << item_stats
    end
    item_array
  end

end
