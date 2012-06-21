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
end
