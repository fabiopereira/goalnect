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
  
  def charity_path(charity_id)
    "/charities/#{charity_id}"
  end
  
  def charity_donations_path(charity_id)
    "/charities/#{charity_id}/donations"
  end
  
  def current_month_donations_pdf_path(charity_id)
    "/charities/#{charity_id}/current_month_donations_pdf.pdf"
  end
  
  def previous_month_donations_pdf_path(charity_id)
    "/charities/#{charity_id}/previous_month_donations_pdf.pdf"
  end
  
  def is_current_user_charity_admin?(charity_id)
    current_user && current_user.charity_id && current_user.charity_id.to_s == charity_id.to_s
  end
  
  def charity_show_goals_path(charity_id)
    "/charities/#{charity_id}/show_goals"
  end
  
end
