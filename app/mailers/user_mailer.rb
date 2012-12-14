class UserMailer < ActionMailer::Base
  default from: "team@goalnect.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.donation_received.subject
  #
  def donation_received donation
    @goal_donation = donation
    mail to: donation.goal.achiever.email
  end
  
  def goal_without_donations goal
    @goal = goal
    mail to: goal.achiever.email
  end

end
