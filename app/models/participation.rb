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

class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
