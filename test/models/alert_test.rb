# == Schema Information
#
# Table name: alerts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :text
#  severity    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  hoa_id      :integer
#  progress    :string(255)      default("new")
#  assignee_id :integer
#  archived    :boolean          default(FALSE)
#  attachment  :string(255)
#

require 'test_helper'

class AlertTest < ActiveSupport::TestCase
  test 'validations' do
    are_attrs_validated?(Alert,[:title,:user_id,:hoa_id,:progress])
  end
end
