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

class Event < ActiveRecord::Base
  # Validations
  validates :date,
            :title,
            :user_id,
            :hoa_id,
            presence: true

  attr_writer :hour, :min

  # Comments
  acts_as_commentable

  # Associations
  belongs_to :user
  belongs_to :hoa
  has_many :participations
  has_many :users, through: :participations
end
