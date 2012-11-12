class StaticController < ApplicationController
  # Maintained temporarily because we have already sent out some links with how-it-works
  def faq
    respond_to do |format|
      format.html {render "/static/how-it-works-#{I18n.locale}.html.erb"}
    end
  end
  
  def sample_pagseguro_file
    respond_to do |format|
      format.xml 
    end
  end
  
  def static_content
    if params[:static_content] == 'faq'
      return faq
    end 
    
    respond_to do |format|
      format.html {render "/static/#{params[:static_content]}-#{I18n.locale}.html.erb"}
    end
  end
end
