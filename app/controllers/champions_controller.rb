class ChampionsController < ApplicationController
require 'json'
require 'open-uri'
  def index
    league_api = LeagueAPI.new
    champion_list
  end

  def show
    if params[:id] == "Wukong"
      params[:id] = "MonkeyKing"
    end
    champion_stats
    champion_lore
  end

  private




end
