class PagseguroFee

  def self.populate_pagseguro_fees options
    token_emails = retrieve_token_emails
    token_emails.each do |token_email|
      options[:token] = token_email[:token]
      options[:email] = token_email[:email]
      options[:page_number] = 1
      process_pagseguro_fee options
    end
  end
 
  def self.process_pagseguro_fee options
    result = PagseguroConsultApi.pagseguro_fee_list options
    if result
      update_pagseguro_fee result, options
    end
  end
  
  def self.retrieve_token_emails
    token_emails = []
    token_emails << {:token => PagSeguro.config["authenticity_token"], :email => PagSeguro.config["email"]}
    charities = Charity.where("pagseguro_email is not null and pagseguro_email != ?", PagSeguro.config["email"])
    charities.each do |charity|
      if charity.pagseguro_authenticity_token && charity.pagseguro_email
        token_emails << {:token => charity.pagseguro_authenticity_token, :email => charity.pagseguro_email}
      end
    end
    token_emails
  end

  def self.update_pagseguro_fee result, options
    fee_list = result[:fee_list]
    fee_list.each do |fee|
      GoalDonation.update_all(['pagseguro_fee = ?', fee[:fee_amount]], ['id = ?', fee[:reference_id]])
    end
    if result[:total_pages] != result[:current_page]
      options[:page_number] = result[:current_page] + 1
      process_pagseguro_fee options
    end
  end
  
  
end
