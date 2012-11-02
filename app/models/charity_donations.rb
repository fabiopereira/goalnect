class CharityDonations
  attr_accessor :from, :to, :charity, :donations, :total_donations, :total_pagseguro_fee, :total_goalnect_fee, :total_net_donations 
  
    def initialize(options)
      self.from = options[:from]
      self.to = options[:to]
      self.charity = Charity.find(options[:charity_id])
      puts 'charity!!!! -> ' + charity.to_s
      puts 'from to => ' + from.to_s + "   " + to.to_s
      self.donations = GoalDonation.find_all_between_dates_by_charity charity.id, from, to
      calculate_summary
   end
   
  def calculate_summary
     self.total_donations = sum_gross_donation_amount
     self.total_goalnect_fee = sum_goalnect_fee
     self.total_pagseguro_fee = sum_pagseguro_fee
     self.total_net_donations = total_donations - total_goalnect_fee - total_pagseguro_fee
  end
  
  def sum_gross_donation_amount
      total = 0          
      if donations
        donations.each{ |d| total = total + d.amount }  
      end
      total
  end
      
  def sum_goalnect_fee
      total = 0    
      if donations      
        donations.each{ |d| total = total + d.goalnect_fee if d.goalnect_fee }
      end
      total
  end
      
  def sum_pagseguro_fee
      total = 0          
      if donations
        donations.each{ |d| total = total + d.pagseguro_fee if d.pagseguro_fee }
      end
      total
  end
  
end

