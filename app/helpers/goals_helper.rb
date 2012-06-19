module GoalsHelper
  def new_goal_path(user_url)
    "/#{user_url}/goals/new"
  end

  def goals_path(user_url)
    "/#{user_url}/goals"
  end

  def edit_goal_path(user_url, goal_id)
    "/#{user_url}/goals/edit/#{goal_id}"
  end

  def show_goal_path(user_url, goal_id)
    "/#{user_url}/goals/show/#{goal_id}"
  end
end
