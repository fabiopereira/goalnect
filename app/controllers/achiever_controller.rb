class AchieverController < ApplicationController
  def view
    user_username = params[:user_username]
    if (!user_username)
      user_username = current_user.username
    end

    @achiever = User.find_by_username(user_username)
  end
  
  def search
    q = params[:q]
    @achievers = User.search(q)
  end
end
