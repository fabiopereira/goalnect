require 'acceptance/support/user_steps'

module PointSteps
  include UserSteps
  
  def ensure_user_has_points point_type, username, expected_points
    visit_user_profile_by_username username
    page.find("##{point_type.to_s}_points").should have_content(expected_points)
  end
  
  def redeem_points username, available_points
    ensure_logged_in username
    visit_user_profile_by_username username
    click_on "Statement"
    click_on "Redeem #{available_points} points"
    page.should have_content available_points
    find(".submit").click
    page.should have_content "CPF can't be blank"
    fill_in 'redemption_point_transaction_cpf', :with => Given.a_valid_cpf
    find(".submit").click
    page.should have_content "Congratulations, you have redeemed #{available_points} points"
  end
  
end

RSpec.configuration.include PointSteps, :type => :acceptance

