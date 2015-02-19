class MasteriesController < ApplicationController

  def index
    @mastery_pages = Summoner.new.summoner_masteries(current_user.summoner_id)
  end

end
