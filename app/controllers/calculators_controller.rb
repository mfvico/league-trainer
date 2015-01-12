class CalculatorsController < ApplicationController

  def index

  end

  def show
    @calculator = Calculator.new
    champion_stats
    champion_lore
  end

end
