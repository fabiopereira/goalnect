module ImageHelper
   
  def img_tag model, image_type
    img_tag_null_safe model.class.name, model, image_type
  end
  
  def img_tag_null_safe model_name, model, image_type
    image_tag(img_src(model_name, model, image_type), :class => "#{model_name.downcase}")
  end
  
  def img_src model, image_type
    img_src model.class.name, model, image_type
  end
  
  def img_src model_name, model, image_type
    model_has_image = model && model.image? && model.image_url(image_type)
    image_url = model_has_image ? model.image_url(image_type) : "nopic/#{model_name.downcase}-nopic-#{image_type}.png"
  end


end