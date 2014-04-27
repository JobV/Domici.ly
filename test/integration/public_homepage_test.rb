require 'test_helper'

class PublicHomepageTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
  end

  test 'visiting an subdomain without extension shows the homepage' do
    visit public_homepage_url(subdomain: @hoa.subdomain_name)
    page_should_contain @hoa.name
  end
end
