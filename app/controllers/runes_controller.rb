class RunesController < ApplicationController

  def index
    @rune_pages = Summoner.new.summoner_runes(current_user.summoner_id)
  end

  def show

  @rune_page = Rune.new.rune_page(current_user.summoner_id, params[:id].to_i)

  end


end
