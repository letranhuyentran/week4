class MoviesController < ApplicationController

  def index
  end

  def create
    Movie.create :title => params["title"],
                 :year => params["year"],
                 :poster_url => params["poster_url"]
    redirect_to "/"
  end
end
