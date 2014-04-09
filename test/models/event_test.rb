# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :datetime
#  title       :string(255)
#  location    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  hoa_id      :integer
#  description :text
#
require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'validations' do
    are_attrs_validated?(Event,[:date,:user_id,:hoa_id,:title])
  end
end
