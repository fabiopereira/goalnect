ActiveAdmin.register GoalTemplate do
  form(:html => { :multipart => true }) do |f|
      f.inputs "GoalTemplate" do
        f.input :title
        f.input :description
        f.input :locale
        f.input :image, :as => :file
        f.input :active
      end
      f.buttons
  end
end
