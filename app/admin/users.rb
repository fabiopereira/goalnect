ActiveAdmin.register User do

  form do |f|
        f.inputs "Details" do
          f.input :email
          f.input :username
          f.input :charity
          f.input :country_id
          f.input :dob
        end
        f.inputs "Content" do
          f.input :about_me
        end
        f.buttons
    end

end
