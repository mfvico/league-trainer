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
    rune_count(@rune_page)
    rune_compiling(@rune_hash)

  end

  private

  def rune_count(rune_page)
    @rune_hash = {}
    rune_page[:slots].each do |slot|
      @rune_hash[slot[:runeId]] ||= {}
      @rune_hash[slot[:runeId]][:count] ||=0
      @rune_hash[slot[:runeId]][:count] += 1
    end
  end

  def rune_compiling(rune_hash)
    rune_hash.each do |id, stats|
      stats[:stats] = Rune.new.rune_data('stats', id)
    end
  end
end
