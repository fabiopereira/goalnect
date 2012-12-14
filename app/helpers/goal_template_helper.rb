module GoalTemplateHelper
  
  def event_show_path(event_id)
    "/events/#{event_id}"
  end
  
  def commit_to_event_path(event_title)
   "/goals/new?goal_template=#{event_title}"
  end
  
  
end
