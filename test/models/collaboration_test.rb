# == Schema Information
#
# Table name: collaborations
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  collaborable_id   :integer
#  collaborable_type :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class CollaborationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
