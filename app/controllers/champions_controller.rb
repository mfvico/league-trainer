class ChampionsController < ApplicationController
require 'json'
require 'open-uri'
  def index
    league_api = LeagueAPI.new
    @champions = JSON.parse open('http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion.json').read
  end

  def show
    @champion = JSON.parse open("http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion/#{params[:id]}.json").read
    @hp = stats["hp"]
    @hpregen = stats["hpregen"]
    @partype = @champion["data"]["#{params[:id]}"]["partype"]
    @mp = stats["mp"]
    @mpregen = stats["mpregen"]
    @movespeed = stats["movespeed"]
    @armor = stats["armor"]
    @armorperlevel = stats["armorperlevel"]
    @spellblock = stats["spellblock"]
    @spellblockperlevel = stats["spellblockperlevel"]
    @attack_damage = stats["attackdamage"]
    @attack_damage_per_level = stats["attackdamageperlevel"]
  end

  private

  def stats
    @champion["data"]["#{params[:id]}"]["stats"]
  end


end
