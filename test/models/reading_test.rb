# == Schema Information
#
# Table name: readings
#
#  id            :integer          not null, primary key
#  readable_id   :integer
#  user_id       :integer          not null
#  readable_type :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
