module AchieverHelper

def current_user_is_achiever?(achiever)
  current_user && current_user.id == achiever.id
end

def user_image(user, image_type)
   if (user.image?) && user.image_url(image_type)
      image_tag user.image_url(image_type)
   else 
      image_tag "achiever-nopic-#{image_type}.jpg"
   end 
end

end
