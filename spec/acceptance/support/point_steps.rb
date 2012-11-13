require 'acceptance/support/user_steps'

module PointSteps
  include UserSteps
  
  def ensure_user_has_points point_type, username, expected_points
    visit_user_profile_by_username username
    page.find("##{point_type.to_s}_points").should have_content(expected_points)
  end
  
end

RSpec.configuration.include PointSteps, :type => :acceptance

