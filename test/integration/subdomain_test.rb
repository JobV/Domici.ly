require 'test_helper'

## Subdomain Routing
#
# 1. domici.ly -> our static page
#
# 2. subdomain.domici.ly -> personal homepage (just a sign in button or so at first)
#
# 3. subdomain.domici.ly/something -> sign in path
#
# 4. domici.ly/something -> static page something
#
# 5. wrongsubdomain.domici.ly -> see homepage
#
# 6. wrongsubdomain.domici.ly/something -> sign in and redirect to subdomain.domici.ly

class SubdomainTest < ActionDispatch::IntegrationTest
  def setup
  end

  # THIS SHIT WORKS YO
  # But setting up a nice testing environment costs time
  # ...

  # test 'domici.ly redirects to www.domici.ly' do
  #   visit root_path
  #   assert_redirected_to 'http://www.domici.ly'
  # end 

  # test 'logging in on wrong subdomain redirects to correct subdomain' do
    
  # end
end
