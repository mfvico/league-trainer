class ChampionsController < ApplicationController
require 'json'
require 'open-uri'
  def index
    league_api = LeagueAPI.new
    @champions = Champion.new.champion_list
  end

  def show
    if params[:level] == nil
      @champion = Champion.new.champion_info('all', params[:id])
    else
      level = params[:level].to_i
      @champion = Champion.new.stats_per_level('all', params[:id], level)
    end
  end

end
