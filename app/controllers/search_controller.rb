class SearchController < ApplicationController
  MIN_SEARCH_QUERY_LENGTH = 3

  def search
    @achievers = []
    @charities = []
    q = params[:q]
    if q.length >= MIN_SEARCH_QUERY_LENGTH || q == "goalnect:all"
      if q == "goalnect:all"
        q = ""
      end 
      
      @achievers = User.search(q)
      @charities = Charity.search(q)
      
      @goals = Goal.search(q)
      @achievers += @goals.collect { |g| g.achiever }
      
      @achievers = @achievers.uniq { |a| a.id }
    else
      flash[:error] = t "errors.search.length", :min => MIN_SEARCH_QUERY_LENGTH
    end
  end
  
end
