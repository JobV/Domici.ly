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

  # unread gem
  acts_as_readable on: :created_at

  # Comments
  acts_as_commentable

  # Associations
  belongs_to :user
  belongs_to :hoa
  has_many :participations
  has_many :users, through: :participations

  include PublicActivity::Model
  tracked only: [:create], 
    owner:  Proc.new{ |controller, model| controller && controller.current_user }, 
    hoa_id: Proc.new{ |controller, model| controller && controller.current_user.hoa.id }

  has_many :collaborations, as: :collaborable
end
