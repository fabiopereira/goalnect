ActiveAdmin.register Goal do
  form do |f|
      f.inputs "Goal" do
        f.input :title
        f.input :description
        f.input :due_on
        f.input :owner
        f.input :achiever
        f.input :goal_stage_id, :as => :select, :collection =>  GoalStage.all
        f.input :charity
        f.input :target_amount
        f.input :publish_home
      end
      f.buttons
  end
end
