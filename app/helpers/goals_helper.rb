module GoalsHelper
  
  def new_goal_path(user_username)
    "/#{user_username}/goals/new"
  end

  def goals_path(user_username)
    "/#{user_username}/goals"
  end

  def edit_goal_path(user_username, goal_id)
    "/#{user_username}/goals/edit/#{goal_id}"
  end

  def show_goal_path(user_username, goal_id)
    "/#{user_username}/goals/show/#{goal_id}"
  end

  def show_goal_path_by_goal(goal)
    show_goal_path goal.achiever.username, goal.id
  end

  def donate_goal_path(goal_id)
    "/goal_donations/new/#{goal_id}"
  end


  def i_support_goal_path(user_username, goal_id)
    "/#{user_username}/goals/i_support/#{goal_id}"
  end


  def i_dont_support_path(user_username, goal_id)
    "/#{user_username}/goals/i_dont_support/#{goal_id}"
  end


  def accept_challenge_path(user_username, goal_id)
    "/#{user_username}/goals/accept_challenge/#{goal_id}"
  end
  
  def reject_challenge_path(user_username, goal_id)
    "/#{user_username}/goals/reject_challenge/#{goal_id}"
  end
  
  def goal_report_abuse_path(user_username, goal_id)
    "/#{user_username}/goals/report_abuse/#{goal_id}"
  end
  
  def goal_template_path(goal_template_title)
    "/goal_template/i_commit?goal_template=#{goal_template_title}"
  end
  
end
