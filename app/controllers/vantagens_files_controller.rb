class VantagensFilesController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def show_last_10
    @vantagens_files = VantagensFile.find(:all, :order => "id desc", :limit => 10)
     respond_to do |format|
      format.html {render 'show_last_10.html.erb'}
      format.json { render json: @vantagens_files }
    end
  end
  
  def process_file
    VantagensFileGenerator.xml
    show_last_10
  end
  
end