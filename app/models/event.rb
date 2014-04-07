# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  date       :datetime
#  name       :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  hoa_id     :integer
#

class Event < ActiveRecord::Base

  attr_writer :hour, :min

  # Comments
  acts_as_commentable

  # Associations
  belongs_to :user
  belongs_to :hoa
  has_many :participations
  has_many :users, through: :participations
end
