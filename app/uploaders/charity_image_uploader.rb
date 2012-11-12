class CharityImageUploader < ImageUploader
  
  version :thumb do
    resize_to_fit(180, 180)
  end

  # Create different versions of your uploaded files:
  version :thumbmini, :from_version => :thumb do
    resize_to_fit(50, 50)
  end
  
end