class UserImageUploader < ImageUploader
  
  version :thumb do
    process :crop
    resize_to_fill(180, 180)
  end

  # Create different versions of your uploaded files:
  version :thumbmini, :from_version => :thumb do
    resize_to_fill(50, 50)
  end
  
end