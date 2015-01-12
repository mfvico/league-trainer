class ChampionsController < ApplicationController
require 'json'
require 'open-uri'
  def index
    league_api = LeagueAPI.new
    champion_list
  end

  def show
    @champion = Champion.new(params[:id])
    if params[:id] == "Wukong"
      params[:id] = "MonkeyKing"
    end
    @champion_hash = @champion.stats_at_lvl1(params[:id])

  end

  private




end
