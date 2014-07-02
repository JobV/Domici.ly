# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  presence   :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  test 'validations' do
    are_attrs_validated?(Post,[:title])
  end
end
