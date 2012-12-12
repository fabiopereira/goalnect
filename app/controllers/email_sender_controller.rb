class EmailSenderController < ApplicationController
  before_filter :authenticate_admin_user!
 
  def send_mail_page
  end
 
  def for_donation_received
    email_schedule = EmailSchedule.find_by_email_type_id(EmailType::DONATION_RECEIVED.id)
    time_now = Time.now
    puts "for_goal_without_donations now => #{time_now}"
    donations = GoalDonation.find_approved_donations_between email_schedule.next_start_date, time_now
    if donations && !donations.empty?
      donations.each do |donation|
        UserMailer.donation_received(donation).deliver
      end
    end
    email_schedule.next_start_date = time_now.advance({seconds:1})
    email_schedule.save
    respond_to do |format|
      format.html { redirect_to '/send_emails'  }
    end
  end
  
  def for_goal_without_donations
      email_schedule = EmailSchedule.find_by_email_type_id(EmailType::GOAL_WITHOUT_DONATIONS.id)
      time_now = Time.now
      puts "for_goal_without_donations now => #{time_now}"
      goals = Goal.find_goals_without_donations  email_schedule.next_start_date, time_now
      if goals && !goals.empty?
        goals.each do |goal|
          UserMailer.goal_without_donations(goal).deliver
        end
      end
      email_schedule.next_start_date = time_now.advance({seconds:1})
      email_schedule.save
      respond_to do |format|
        format.html { redirect_to '/send_emails'  }
      end
  end
  
end