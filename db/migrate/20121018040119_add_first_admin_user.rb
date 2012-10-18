class AddFirstAdminUser < ActiveRecord::Migration
  def up
    user = User.find_by_email('team@goalnect.com')
    if user == nil
      user =  User.new(:email => 'team@goalnect.com', :password => '123456', :password_confirmation => '123456', :username => 'teamgoalnect', :screen_name => 'Team Goalnect')
    end
    user.admin = true
    user.save
  end

  def down
    User.destroy_all(:email => 'team@goalnect.com')
  end
end
