class RunesController < ApplicationController

  def index
    @rune_page = Summoner.new.summoner_runes(current_user.summoner_id)
  end


end
