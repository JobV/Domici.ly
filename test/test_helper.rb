# require 'simplecov'
# SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Minitest reporters for colors
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

require 'sidekiq/testing'
require 'helper_methods/role_test_helper'
Devise.mailer = Devise::Mailer


require 'capybara/rails'
require 'public_activity/testing'
PublicActivity.enabled = true
class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  def sign_in(user)
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'jobiscool'
    click_on 'Log in'
  end
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

def are_attrs_validated?(model, attributes)
  m = model.new
  attributes.each do |at|
    m[at] = nil
    assert !m.valid?, "#{m} should be invalid!"
    assert m.errors[at].any?, "Expected #{model} to validate #{at}, but it didn't!"
  end
end

def default_test_setup
  @hoa = create(:hoa)

  # Random user
  @home_owner = create(:user, hoa: @hoa, first_name: 'Job')

  # Maintenance person
  @maintenance = create(:user, hoa: @hoa, first_name: 'Piet')
  @maintenance.add_role :maintenance, @hoa

  # Board member
  @moderator = create(:user, hoa: @hoa, first_name: 'Steve')
  @moderator.add_role :moderator, @hoa
end

# def get_subdomain(subdomain = 'jaxons')
#   @request.host = "#{subdomain}.localhost"
# end

class ExampleAlert
  def self.title
    'Test melding titel'
  end

  def self.body
    'De body van een testende melding.'
  end

  def self.tag
    'tag1'
  end

  def self.assignee
    'Job'
  end
end
