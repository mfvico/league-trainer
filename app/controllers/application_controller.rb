class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require "open-uri"

  def current_user
    User.find_by(id: session[:user_id])
  end

  def champion_list
    raw_data = JSON.parse open('http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion.json').read
    @champion_list = []
    raw_data["data"].each do |value|
      value.each do |champion|
        if champion.class == String
          if champion == "MonkeyKing"
            @champion_list << "Wukong"
          else
            @champion_list << champion
          end
        end
      end
    end
    @champion_list = @champion_list.sort_by{|name| name.downcase}
  end


  def champion_stats
    champion = JSON.parse open("http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion/#{params[:id]}.json").read
    stats = champion["data"]["#{params[:id]}"]["stats"]
    @hp = stats["hp"]
    @hpregen = stats["hpregen"]
    @partype = champion["data"]["#{params[:id]}"]["partype"]
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

  def champion_stats_at_18
    champion_stats
  end

  def champion_lore
    champion = JSON.parse open("http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion/#{params[:id]}.json").read
    @name = champion["data"]["#{params[:id]}"]["name"]
    @title = champion["data"]["#{params[:id]}"]["title"]
  end

  helper_method :current_user
  helper_method :champion_list
  helper_method :champion_stats
  helper_method :champion_lore

end
