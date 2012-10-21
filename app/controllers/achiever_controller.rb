class AchieverController < ApplicationController
  before_filter :authenticate_user!, :except => [:view, :search] 
  
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
  
  def edit_profile_photo
    edit
  end
  
  def crop
    @user = current_user
    @user.crop_x = params[:user][:crop_x]
    @user.crop_y = params[:user][:crop_y]
    @user.crop_h = params[:user][:crop_h]
    @user.crop_w = params[:user][:crop_w]
    @user.save    
    respond_to do |format|
      format.html { render action: "edit_profile_photo"  }
    end
  end
    
  def update
      @user = current_user
      respond_to do |format|
        if  @user.update_attributes(params[:user])
          if params[:user][:image].present?
            format.html { render action: "edit_profile_photo"  }
          else
            format.html { redirect_to root_path}
          end
        else
          format.html { render action: "edit"  }
        end
      end         
  end
  
end
  