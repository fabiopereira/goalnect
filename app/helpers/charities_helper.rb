module CharitiesHelper
  
  def charity_image charity, image_type
    charity_has_image = charity.image? && charity.image_url(image_type)
    image_url = charity_has_image ? charity.image_url(image_type) : "charity-nopic-#{image_type}.jpg" 
    image_tag image_url
  end
  
end
