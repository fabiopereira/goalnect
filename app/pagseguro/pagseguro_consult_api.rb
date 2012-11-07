class PagseguroConsultApi
  
  HISTORY_URL = 'https://ws.pagseguro.uol.com.br/v2/transactions?initialDate=%INITIAL_DATE&finalDate=%FINAL_DATE&page=%PAGE_NUMBER&maxPageResults=100&email=%EMAIL&token=%TOKEN'
  
  def self.transaction_history options
    set_default_values options
    if options[:email] && options[:token]
        initial_date = options[:initial_date].strftime("%Y-%m-%dT00:00")
        final_date = options[:final_date].strftime("%Y-%m-%dT00:00")
        page_number = options[:page_number]
        email = options[:email]
        token = options[:token]
        url = HISTORY_URL.sub('%INITIAL_DATE', initial_date).sub('%FINAL_DATE', final_date).sub('%PAGE_NUMBER', page_number.to_s).sub('%EMAIL', email).sub('%TOKEN', token)
        response = Restfulie.at(url).get
        response.resource
    else
      Goalog.critical 'Email and Token are required to consult pagseguro fees'
    end
  end
  
  def self.set_default_values options
    options[:initial_date] = options[:initial_date] ? options[:initial_date] : 7.days.ago
    options[:final_date] = options[:final_date] ? options[:final_date] : Date.today
    options[:page_number] = options[:page_number] ?  options[:page_number] : 1
  end
  
end
