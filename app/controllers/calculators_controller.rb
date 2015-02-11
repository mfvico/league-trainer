class CalculatorsController < ApplicationController

  def index
    @champion = champion_list
    @test = Calculator.new(101).data_calculation([3087])
  end

  def show


  end

end
