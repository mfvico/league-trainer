class CalculatorsController < ApplicationController

  def show
    if params[:build] == nil
      @champion = Champion.new.stats_per_level(['stats', 'partype'], params[:id], 18)
      @champion[:stats_with_items] = @champion[:stats]
      @champion[:stats_with_items][:ap] = 0
      @champion[:stats_with_items][:lifesteal] = 0

    else
      @champion = Calculator.new(params[:id]).data_calculation(params[:build])
      @item_array = Calculator.new(params[:id]).item_array(params[:build])
    end

  end

end
