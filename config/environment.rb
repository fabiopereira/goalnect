# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Goalnect::Application.initialize!

#ENV['RAILS_ENV'] ||= 'production'

Date::DATE_FORMATS.merge!(:default => "%d/%m/%Y")

unless Rails.env.development?
	Rails.logger = Le.new(ENV["letoken"])
end