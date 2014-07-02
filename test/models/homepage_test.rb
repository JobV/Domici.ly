# == Schema Information
#
# Table name: homepages
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  subdomain_name :string(255)
#  hoa_id         :integer
#

require 'test_helper'

class HomepageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
