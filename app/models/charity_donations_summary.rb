class CharityDonationsSummary
     
      attr_accessor :from, :to, :charity_id
      attr_accessor :donations_amount, :net_donations_amount, :total_goalnect_fee, :total_pagseguro_fee
      
      def initialize(options)
        self.from = options[:from]
        self.to = options[:to]
        self.charity_id = options[:charity_id]
        calculate_summary
      end
      
      def calculate_summary
        self.donations_amount = GoalDonation.sum_donation_amount_by_charity_between_dates charity_id, from, to
        self.total_pagseguro_fee = GoalDonation.sum_pagseguro_fees_by_charity_between_dates charity_id, from, to
        self.total_goalnect_fee = GoalDonation.sum_goalnect_fees_by_charity_between_dates charity_id, from, to
        self.net_donations_amount = donations_amount - total_pagseguro_fee - total_goalnect_fee
      end

end
