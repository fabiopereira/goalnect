class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes
  process :set_content_type

  def self.is_file_storage_env
    Rails.env.development? or Rails.env.test?
  end
  
  # Choose what kind of storage to use for this uploader:
  storage is_file_storage_env ? :file : :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  
end
