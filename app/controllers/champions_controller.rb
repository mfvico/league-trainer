class ChampionsController < ApplicationController
require 'json'
require 'open-uri'
  def index
    @champions = Champion.new.champion_list(['all'])[:data].sort_by {|key, value| key}
    binding.pry
  end

  def show
    if params[:level] == nil
      @champion = Champion.new.champion_info(['all'], params[:id])
    else
      level = params[:level].to_i
      @champion = Champion.new.stats_per_level(['all'], params[:id], level)
    end
  end

end
