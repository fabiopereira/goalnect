class StaticController < ApplicationController
  def faq
    respond_to do |format|
      format.html {render "/static/how-it-works-#{I18n.locale}.html.erb"}
    end
  end
end
