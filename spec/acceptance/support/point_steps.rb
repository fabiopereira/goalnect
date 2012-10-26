require 'acceptance/support/user_steps'

module PointSteps
  include UserSteps
  
  def ensure_user_has_points_active username, expected_points
    ensure_user_has_points username, expected_points, true
  end 
  
  def ensure_user_has_points_locked username, expected_points
    ensure_user_has_points username, expected_points, false
  end 
  
  def ensure_user_has_points username, expected_points, active_boolean
    visit_user_profile_by_username username
    page.find("#total-points-#{active_boolean}").should have_content(expected_points)
  end
  
end

RSpec.configuration.include PointSteps, :type => :acceptance

