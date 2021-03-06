module UserImageHelper
  
class UserImageUrl
  
  IMAGE_TYPE_TO_FACEBOOK_TYPE = {
    :thumb => "large",
    :thumbmini => "small"
  }
  
  def initialize(user, image_type)
    @user = user
    @image_type = image_type
  end
  
  def user_image_url
    [
      user_uplaoded_image_url,
      facebook_image_url,
      no_pic_image_url
    ].find { |url| url != nil } 
  end
  
  def user_uplaoded_image_url
    @user && @user.image? && @user.image_url(@image_type) ? @user.image_url(@image_type) : nil
  end
  
  def facebook_image_url
    if @user && @user.authentications
       @user.authentications.each do |auth|
         if auth.provider == "facebook"
           return "https://graph.facebook.com/#{auth.uid}/picture?type=#{IMAGE_TYPE_TO_FACEBOOK_TYPE[@image_type]}"
         end
       end 
     end 
     return nil
  end
  
  def no_pic_image_url
    "achiever-nopic-#{@image_type}.jpg"
  end
  
end

def user_image(user, image_type)
   image_tag(user_image_url(user, image_type), :class => "user-#{image_type}")
end

def user_image_url(user, image_type)
   UserImageUrl.new(user, image_type).user_image_url
end

def user_full_image_url(user, image_type)
   user_image_url =  UserImageUrl.new(user, image_type)
   image_url = user_image_url.user_image_url
   if user_image_url.no_pic_image_url == image_url
    image_url = asset_path(image_url)
   end
   image_url
end

end
