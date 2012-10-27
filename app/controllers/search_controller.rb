class SearchController < ApplicationController

  def search
    q = params[:q]
    @achievers = User.search(q)
    @charities = Charity.search(q)
  end
  
end
