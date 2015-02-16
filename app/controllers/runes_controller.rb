class RunesController < ApplicationController

  def index
    @rune_pages = Summoner.new.summoner_runes(current_user.summoner_id)
  end

  def show

    raw_data = Summoner.new.summoner_runes(current_user.summoner_id)
    raw_data.each do |id, pages|
      pages[:pages].each do |page|
        if page[:id] == params[:id].to_i
          @rune_page = page
        end
      end
    end
  
  end

  private



end
