require 'spec_helper'

describe PagseguroFee do
  
  
  it 'should update fee amount' do
    goal_donation = FactoryGirl.create(:goal_donation)
    fee_amount = 1.45
    fee_list = [{:reference_id => goal_donation.id, :fee_amount => fee_amount}]
    result = {:total_pages => 1, :current_page => 1, :fee_list => fee_list}
    PagseguroFee.update_pagseguro_fee result, {}
    goal_donation = GoalDonation.find(goal_donation.id)
    goal_donation.pagseguro_fee.should be == fee_amount
  end
  
  it 'should return list with 3 charities pagseguro emails' do
    
    create_charity 'TOKEN1', 'email1@email.com','charity1'
    create_charity 'TOKEN2', 'email2@email.com','charity2'
    create_charity nil, nil,'charity3'
    create_charity PagSeguro.config["authenticity_token"], PagSeguro.config["email"], 'charity4'
    create_charity nil, nil,'charity5'
    create_charity PagSeguro.config["authenticity_token"], PagSeguro.config["email"], 'charity6'
    
    token_emails = PagseguroFee.retrieve_token_emails
    token_emails.size.should be == 3
    
    tokens = []
    emails = []
    token_emails.each do |token_email|
      tokens << token_email[:token]
      emails << token_email[:email]
    end
    
    tokens.include?('TOKEN1')
    tokens.include?('TOKEN2')
    tokens.include?(PagSeguro.config["authenticity_token"])
    
    emails.include?('email1@email.com')
    emails.include?('email2@email.com')
    tokens.include?(PagSeguro.config["email"])
    
  end

  def create_charity pagseguro_authenticity_token, pagseguro_email, nickname
    Charity.create({:charity_name => nickname, :contact_name => 'Contact', :email => 'bla@bla.com', :phone => '0000', :nickname => nickname, :pagseguro_authenticity_token => pagseguro_authenticity_token, :pagseguro_email => pagseguro_email})
  end
  
end