module AchieverHelper

def current_user_is_achiever?
   current_user && current_user.id == @achiever.id
end

end
