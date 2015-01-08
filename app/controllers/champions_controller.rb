class ChampionsController < ApplicationController
require 'json'
require 'open-uri'
  def index
    league_api = LeagueAPI.new
    @champions = JSON.parse open('http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion.json').read
  end

  def show
    @champion = JSON.parse open("http://ddragon.leagueoflegends.com/cdn/4.20.1/data/en_US/champion/#{params[:id]}.json").read
    @hp = @champion["data"]["#{params[:id]}"]["stats"]["hp"]
    @hpregen = @champion["data"]["#{params[:id]}"]["stats"]["hpregen"]
  end


end
