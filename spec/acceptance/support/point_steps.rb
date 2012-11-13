require 'acceptance/support/user_steps'

module PointSteps
  include UserSteps
  
  def ensure_user_has_points_active username, expected_points
    ensure_user_has_points username, expected_points, "#available_points"
  end 
  
  def ensure_user_has_points_locked username, expected_points
    ensure_user_has_points username, expected_points, "#blocked_points"
  end 
  
  def ensure_user_has_points_redeemed username, expected_points
    ensure_user_has_points username, expected_points, "#redeemed_points"
  end 
  
  def ensure_user_has_points username, expected_points, points_span_id
    visit_user_profile_by_username username
    page.find(points_span_id).should have_content(expected_points)
  end
  
end

RSpec.configuration.include PointSteps, :type => :acceptance

