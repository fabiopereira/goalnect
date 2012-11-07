class PagseguroFee

  def self.populate_pagseguro_fees options
    token_emails = retrieve_token_emails
    token_emails.each do |token_email|
      options[:token] = token_email[:token]
      options[:email] = token_email[:email]
      options[:page_number] = 1
      update_pagseguro_fee options
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

  def self.update_pagseguro_fee options
    result = PagseguroConsultApi.transaction_history options
    if result == 'Unauthorized'
      Goalog.critical "Pagseguro - Unauthorized access for #{options[:email]}"
      return
    end
    
    if !result.transactionSearchResult || result.transactionSearchResult.resultsInThisPage.to_i == 0
      Goalog.debug "There is no transaction for this period (#{options[:email]} - #{options[:initial_date]} - #{options[:final_date]})"
      return
    end 
    
    transactions = result.transactionSearchResult.transactions.transaction
    transactions.each do |transaction|
      GoalDonation.update_all(['pagseguro_fee = ?', transaction.feeAmount.to_f], ['id = ?', transaction.reference.to_i])
    end
    total_pages = result.transactionSearchResult.totalPages
    current_page = result.transactionSearchResult.currentPage
    if total_pages != current_page
      options[:page_number] = current_page.to_i + 1
      update_pagseguro_fee options
    end
  end
  
end
