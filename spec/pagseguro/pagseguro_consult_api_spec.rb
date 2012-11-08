require 'spec_helper'

describe PagseguroConsultApi do
  
  
  it 'should return list with 2 transactions' do
    options = {:initial_date => Date.parse('01-11-2012'), :final_date => Date.parse('08-11-2012'), :email => 'camilahayashi@gmail.com', :token => '06AFDC23913D4942A20527527249ACC0'}
    result = PagseguroConsultApi.pagseguro_fee_list options
    fee_list = result[:fee_list]
    fee_list.each do |fee|
      fee[:fee_amount].should be == 0.46
      [12,13].include?(fee[:reference_id])
    end
    result[:total_pages].should be == 1
    result[:current_page].should be == 1
   
  end
  
  
end