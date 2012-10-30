module CharitiesHelper
  
  def charity_image charity, image_type
   
    image_tag(define_image_to_use(charity, image_type))
  end
  
  def charity_image_align charity, image_type, align
    charity_has_image = charity.image? && charity.image_url(image_type)
    image_url = charity_has_image ? charity.image_url(image_type) : "charity-nopic-#{image_type}.jpg" 
    image_tag(define_image_to_use(charity, image_type), :align => align, :style => "padding: 0px 20px 10px 0px;")
  end
  
  def define_image_to_use charity, image_type
     charity_has_image = charity.image? && charity.image_url(image_type)
     image_url = charity_has_image ? charity.image_url(image_type) : "charity-nopic-#{image_type}.jpg"
  end
  
end
