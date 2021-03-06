# encoding: utf-8

class ImageUploader < FileUploader

  # Include RMagick or MiniMagick support:
  #include CarrierWaveDirect::Uploader
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # asset_path("/achiever-nopic-#{@version_name}.jpg")
    # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end           
  
  process :resize_to_limit => [800, 800]

  def crop
      if model.crop_x.present?
        resize_to_limit(800, 800)
        manipulate! do |img|
          x = model.crop_x.to_i
          y = model.crop_y.to_i
          w = model.crop_w.to_i
          h = model.crop_h.to_i
          img.crop!(x, y, w, h)
        end
      end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
