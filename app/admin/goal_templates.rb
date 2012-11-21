ActiveAdmin.register GoalTemplate do
  form(:html => { :multipart => true }) do |f|
      f.inputs "GoalTemplate" do
        f.input :title
        f.input :description
        f.input :locale
        f.input :image, :as => :file
        f.input :active
        f.input :due_on
        f.input :goal_template_type_id, :as => :select, :collection =>  GoalTemplateType.all
        f.input  :description_guide
      end
      f.buttons
  end
end
