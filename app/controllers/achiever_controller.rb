class AchieverController < ApplicationController
  before_filter :authenticate_user!, :except => [:view] 
  
  def view
    user_username = params[:user_username]
    if (!user_username)
      user_username = current_user.username
    end

    @achiever = User.find_by_username(user_username)
    @goalnection_summary = UserGoalnectionSummary.new(@achiever)
  end
  
  def edit
    @user = current_user
  end
  
  def edit_profile_photo
    edit
  end
  
  def crop
    crop_image current_user    
    respond_to do |format|
      format.html { redirect_to root_path  }
    end
  end
    
  def update
      @user = current_user
      respond_to do |format|
        if  @user.update_attributes(params[:user])
          if params[:user] && params[:user][:image].present?
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
  