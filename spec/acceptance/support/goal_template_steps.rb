module GoalTemplateSteps

	def ensure_goal_template_exists
	  goal_template = GoalTemplate.find_by_title_and_active title, true
	  unless goal_template
	    #goal_template
	  end
	end
	
end

RSpec.configuration.include GoalTemplateSteps, :type => :acceptance
