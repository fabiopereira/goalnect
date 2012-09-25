class AchieverController < ApplicationController
  before_filter :authenticate_user!
  
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
  
  def edit
    @user = current_user
  end
  
  def update
      respond_to do |format|
        if current_user.update_attributes(params[:user])
          format.html { redirect_to root_path}
        else
          format.html { render action: "edit"  }
        end
      end
  end
  
end
  