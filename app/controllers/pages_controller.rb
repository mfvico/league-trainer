class PagesController < ApplicationController
  require 'json'
  require 'open-uri'

  def index

  end

  def riot
    render :file => 'riot.txt'
  end

end
