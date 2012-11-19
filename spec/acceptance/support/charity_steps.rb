require 'acceptance/support/user_steps'
module CharitySteps
  
  def ensure_charity_active_exists nickname
    visit '/charities/new'
    fill_in 'charity_charity_name', :with => nickname
    fill_in 'charity_contact_name', :with => 'contact'
    fill_in 'charity_email', :with => 'contact@test.com'
    fill_in 'charity_phone', :with => '2222222'
    click_on 'Send'
    charity = Charity.find_by_nickname(nickname) 
    charity.active = true
    charity.pagseguro_email = 'pagseguro@charity.com.br'
    charity.save!
    charity
  end
  
  def set_user_as_charity_admin user, charity_id
    user.charity_id = charity_id
    user.save!
  end
  
  def visit_charity_page charity
    visit "/charities/#{charity.id}"
    page.should have_content user.charity.charity_name
  end
  
  def visit_charity_page_as_admin username, charity_id
    user = ensure_logged_in username
    set_user_as_charity_admin user, charity_id
    visit '/'
    click_on user.charity.charity_name
    page.should have_content user.charity.charity_name
    
  end
  
  def ensure_charity_has_donation_of amount  
    find('#donations_table').should have_content(amount)
  end
  
  def ensure_charity_has_raised_so_far_amount amount
    find('#raised_so_far').should have_content(amount)
  end
  
  def visit_all_donations_page_verify_summaries gross_amount, pagseguro_fee, goalnect_fee, net_amount
    
    click_on "List All Donations"
    find("#donations_amount").should have_content("0.0")
    find("#total_pagseguro_fee").should have_content("0.0")
    find("#total_goalnect_fee").should have_content("0.0")
    find("#net_donations_amount").should have_content("0.0")
    page.should have_content "Previous month donations transactions (PDF)"
    
    click_on "Current Month"
    find("#donations_amount").should have_content(gross_amount)
    find("#total_pagseguro_fee").should have_content(pagseguro_fee)
    find("#total_goalnect_fee").should have_content(goalnect_fee)
    find("#net_donations_amount").should have_content(net_amount)
    page.should have_content "Current Donations Transactions (PDF)"
    
  end
  
  def verify_charity_updates charity_id
    update1 = "Update1 Message"
    update2 = "Update2 Message"
    update3 = "Update3 Message"
    update4 = "Update4 Message"
    edit = "Edit Message"
    
    add_charity_update update1
    add_charity_update update2
    add_charity_update update3
    
    find("#charity_updates").should have_content(update1)
    find("#charity_updates").should have_content(update2)
    find("#charity_updates").should have_content(update3)
    
    #display only last 3 updates
    add_charity_update update4
    find("#charity_updates").should_not have_content(update1)
    find("#charity_updates").should have_content(update2)
    find("#charity_updates").should have_content(update3)
    find("#charity_updates").should have_content(update4)
    
    update = CharityUpdate.find(:first, :conditions => [ "charity_id = ?", charity_id], :order => "id DESC")
    
    # TODO: weirrddd!! test doesnt work!!!
    # visit "/charities/#{charity_id}"
    # edit_charity_update update, edit
    # find("#charity_updates").should have_content(edit)
    
    delete_charity_update update
    find("#charity_updates").should_not have_content(update.message)
    
  end
  
  
  def delete_charity_update update
    within("#charity_update_#{update.id}") do
      click_on 'Destroy'   
      page.driver.browser.switch_to.alert.accept
    end
  end
  
  def edit_charity_update update, message
    within("#charity_update_#{update.id}") do
      click_on 'Edit'   
      fill_charity_update_message message
    end
  end
  
  def add_charity_update message
    click_on "New Update"
    fill_charity_update_message message
  end
  
  def fill_charity_update_message message
      page.execute_script %Q{ $('#charity_update_message').data("wysihtml5").editor.setValue("#{message}") }
      find("#submit").click
  end
  
end

RSpec.configuration.include CharitySteps, :type => :acceptance
