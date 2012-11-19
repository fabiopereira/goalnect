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
    cpf =  Given.a_valid_cpf
    fill_in 'redemption_point_transaction_cpf', :with => cpf
    find(".submit").click
    page.should have_content "Congratulations, you have redeemed #{available_points} points"
    cpf
  end
  
  def generate_vantagens_file cpf, amount
    
    amount_s = "%.2f" % amount
    amount_s = amount_s.sub(".", ",")
    
    admin = ensure_logged_in 'admin'
    admin.admin = true
    admin.save!
    visit '/vantagens_files/show_last_10'
    find("#process_file_id").click
    
    filename = VantagensFileGenerator.file_name
    page.should have_content filename
    
    file = VantagensFile.find_by_file_name (filename)
    
    redemption = RedemptionPointTransaction.find_by_cpf(cpf)
    redemption.vantagens_file_id.should be == file.id
    
    get  "/uploads/vantagens_file/file/#{file.id}/#{filename}", :format => :xml
    page = Capybara.string response.body
    page.should have_content "123456"
    page.should have_content "08175080000128"
    page.should have_content cpf
    page.should have_content amount_s
    
  end
  
end

RSpec.configuration.include PointSteps, :type => :acceptance

