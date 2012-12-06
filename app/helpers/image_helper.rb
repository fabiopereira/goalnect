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

  def random_img_tag img_srcs
    image_tag(img_srcs[0], :class => "random_img_tag", "data-srcs" => img_srcs.join(","))
  end

  def random_img_tag_for_goal goal, first_img = :goal_template, type = :thumb
    goal_template_img = img_src_full("goaltemplate", goal.goal_template, type)
    charity_img = img_src_full("charity", goal.charity, type)
    achiever_img = user_full_image_url(goal.achiever, type)
    if (first_img == :achiever)
      random_img_tag [achiever_img, goal_template_img, charity_img]
    else 
      random_img_tag [goal_template_img, charity_img, achiever_img]
    end 
  end

  def img_src_full model_name, model, image_type
    model_has_image = model && model.image? && model.image_url(image_type)
    image_url = model_has_image ? model.image_url(image_type) : asset_path("nopic/#{model_name.downcase}-nopic-#{image_type}.png")
  end
  
end