# == Schema Information
#
# Table name: support_messages
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  hoa_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class SupportMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
