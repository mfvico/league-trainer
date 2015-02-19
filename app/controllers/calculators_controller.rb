class CalculatorsController < ApplicationController



  def index
    @champion = champion_list
    @test = Calculator.new(101).data_calculation([3087])
  end

  def show
    if params[:build] == nil
      @champion = Champion.new.stats_per_level('all', params[:id], 18)
      @champion[:stats_with_items] = @champion[:stats]
      @champion[:stats_with_items][:ap] = 0
    else
      @champion = Calculator.new(params[:id]).data_calculation(params[:build])
    end

  end

end
