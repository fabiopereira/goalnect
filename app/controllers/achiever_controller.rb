class AchieverController < ApplicationController
  def view
    user_url = params[:user_url]
    if (!user_url)
      user_url = current_user.url
    end

    @achiever = User.find_by_url(user_url)
  end
  
  def search
    q = params[:q]
    @achievers = User.search(q)
  end
end
