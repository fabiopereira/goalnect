ActiveAdmin.register EmailSchedule do
  form do |f|
      f.inputs "EmailSchedule" do
        f.input :email_type_id, :as => :select, :collection =>  EmailType.all
        f.input :next_start_date
      end
      f.buttons
  end
end
