class CalculatorsController < ApplicationController

  def index
    id = current_user.summoner_id
    if current_user
      runes = Summoner.new.summoner_runes(id)
      @runes = runes[id.to_sym][:pages]
    end
    @champion = Champion.new.champion_list(['info'])

  end

  def show
    binding.pry
    if params[:build] == nil
      @champion = Champion.new.stats_per_level(['stats', 'partype'], params[:id], 18)
      @champion[:stats_with_items] = @champion[:stats]
      @champion[:stats_with_items][:ap] = 0
      @champion[:stats_with_items][:lifesteal] = 0
    else
      @champion = Calculator.new(params[:id]).data_calculation(params[:build], nil, nil)
      @item_array = Calculator.new(params[:id]).item_array(params[:build])
    end

  end

  def create
    params[:rune_page] = params["Runes"]
    params.merge(:rune_page => params["Runes"])
    redirect_to calculator_path(params["Champion"])
  end

end
