module CropImage
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  def crop_image
    image.recreate_versions! if crop_x.present?
  end  
  
  def display_crop_image_view
    true
  end
  
  
end