require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test 'while not logged in show sign up button' do
    visit root_path
    assert page.has_content? 'Sign up'
  end
end
