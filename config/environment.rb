# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Easyblog::Application.initialize!

Time::DATE_FORMATS[:default] = "%d/%m/%Y: %H:%M"
