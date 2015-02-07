class CalculatorsController < ApplicationController

  def index
    @champion = champion_list
    @test = Calculator.new(101).item_compiler([3001])
  end

  def show


  end

end
