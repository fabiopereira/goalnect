module GoalSteps
	def commit_to_a_goal title
	  visit '/'
	  click_on 'New Goal'
	  fill_in 'goal_title', :with => title                                  
	  description = "Description for goal #{title}"
	  page.execute_script %Q{ $('#goal_description').data("wysihtml5").editor.setValue('#{description}') }
    # fill_in 'goal_description', :with => description
    # fill_in 'goal_due_on', :with => 2.months.from_now
	  click_on 'Create Goal'
	  page.should have_content 'Goal was successfully created'
	  Goal.find_by_title title
	end
end

RSpec.configuration.include GoalSteps, :type => :acceptance
