ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Minitest reporters for colors
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

require 'capybara/rails'
class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end

def page_should_contain(content)
  assert page.has_content?(content), "Expected to find #{content} on the page, but didn't find it."
end

def page_should_not_contain(content)
  refute page.has_content?(content), "Found #{content} on the page, but it shouldn't be there!"
end

def page_should_have_button(button_name)
  assert page.has_button?(button_name), "Expected to find button named #{button_name}, but couldn't find it."
end
