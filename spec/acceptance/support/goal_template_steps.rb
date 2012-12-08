require 'acceptance/support/user_steps'

module GoalTemplateSteps
  include UserSteps

	def ensure_goal_template_exists title
	  goal_template = GoalTemplate.find_by_title_and_active title, true
	  unless goal_template
	    FactoryGirl.create(:goal_template, title: title, locale: I18n.locale.to_s)
	  end
	end
	
	def discover_goalnect_and_decide_to_commit_to_goal_template username, goal_template_title, charity
	  goal_template = ensure_goal_template_exists goal_template_title
    ensure_logged_out
    visit '/'
    
    find(:xpath, "//select/option[@value='#{goal_template.title}']")
    page.select goal_template_title, :from => "goal_template"
    
    find(:xpath, '//form[@class="i_commit"]//input[@type="submit"]').click
    
    user_should_be_prompted_for_sign_in_or_sign_up

    user = ensure_username_exists username
    login_user_password_already_in_login_page user.email, "123456"
    goal = commit_to_a_goal_template charity, goal_template
    
    goal.goal_template.should == goal_template
    goal
	end
	
	def ensure_event_exists title, due_on
	  event = GoalTemplate.find_by_title_and_active title, true
	  unless event
	    FactoryGirl.create(:goal_template, title: title, locale: I18n.locale.to_s, goal_template_type_id: GoalTemplateType::EVENT.id, due_on: due_on, publish_home: true)
	  end
	end
	
	def discover_goalnect_and_decide_to_commit_to_an_event username, goal_template_title, due_date, charity
	  goal_template = ensure_event_exists goal_template_title, due_date
    ensure_logged_out
    visit '/'
    
    find("#join_event_#{goal_template.id}").click
    
    user_should_be_prompted_for_sign_in_or_sign_up

    user = ensure_username_exists username
    login_user_password_already_in_login_page user.email, "123456"
    goal = commit_to_a_goal_template charity, goal_template
    goal.due_on == goal_template.due_on
    goal.goal_template.should == goal_template
	end
	
end

RSpec.configuration.include GoalTemplateSteps, :type => :acceptance
