module CharitiesHelper
  
  def charity_image charity, image_type
    link_to img_tag(charity, image_type), charity.full_url
  end
  
  def charity_show_path(charity_id)
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
    current_user && (current_user.admin? || (current_user.charity_id && current_user.charity_id.to_s == charity_id.to_s))
  end
  
  def charity_show_goals_path(charity_id)
    "/charities/#{charity_id}/show_goals"
  end
  
end
