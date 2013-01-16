class PagseguroConsultApi
  
  HISTORY_URL = 'https://ws.pagseguro.uol.com.br/v2/transactions?initialDate=%INITIAL_DATE&finalDate=%FINAL_DATE&page=%PAGE_NUMBER&maxPageResults=50&email=%EMAIL&token=%TOKEN'
  
  def self.pagseguro_fee_list options
    transaction_history = transaction_history options
    if transaction_history
      search_result = transaction_history.transactionSearchResult
      build_pagseguro_fee_list search_result
    end
  end
  
  def self.transaction_history options
    set_default_values options
    if options[:email] && options[:token]
        url = build_up_consult_url options
        response = Restfulie.at(url).get
        validate_transaction_history response.resource, options
    else
      Goalog.critical 'Email and Token are required to consult pagseguro fees'
    end
  end
  
  def self.build_pagseguro_fee_list search_result
    transactions = search_result.transactions.transaction
    fee_list = []
    if search_result.resultsInThisPage.to_i == 1
      fee_list << {:reference_id => transactions.reference.to_i, :fee_amount => transactions.feeAmount.to_f}
    else
      transactions.each do |transaction|
        fee_list << {:reference_id => transaction.reference.to_i, :fee_amount => transaction.feeAmount.to_f}
      end  
    end
    total_pages = search_result.totalPages.to_i
    current_page = search_result.currentPage.to_i
    result = {:total_pages => total_pages, :current_page => current_page, :fee_list => fee_list}
  end
  
  def self.validate_transaction_history result, options
     if result == 'Unauthorized'
        Goalog.critical "Pagseguro - Unauthorized access for #{options[:email]}"
        return nil
      end
      if !result.transactionSearchResult || result.transactionSearchResult.resultsInThisPage.to_i == 0
        Goalog.debug "There is no transaction for this period (#{options[:email]} - #{options[:initial_date]} - #{options[:final_date]})"
        return nil
      end
      result
  end
  
  def self.build_up_consult_url options
    initial_date = options[:initial_date].strftime("%Y-%m-%dT00:00")
    final_date = options[:final_date].strftime("%Y-%m-%dT00:00")
    page_number = options[:page_number]
    email = options[:email]
    token = options[:token]
    HISTORY_URL.sub('%INITIAL_DATE', initial_date).sub('%FINAL_DATE', final_date).sub('%PAGE_NUMBER', page_number.to_s).sub('%EMAIL', email).sub('%TOKEN', token)
  end
  
  def self.set_default_values options
    options[:initial_date] = options[:initial_date] ? options[:initial_date] : options[:days_ago] ? options[:days_ago].to_i.days.ago : 7.days.ago
    options[:final_date] = options[:final_date] ? options[:final_date] : Date.today
    options[:page_number] = options[:page_number] ?  options[:page_number] : 1
  end
  
end
