class VantagensFile < ActiveRecord::Base
  attr_accessible :file, :file_name, :sent_at
  
  mount_uploader :file, FileUploader
  
  validates_presence_of :file_name
  validates_uniqueness_of :file_name
  
end
