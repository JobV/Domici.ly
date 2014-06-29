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
#

class Alert < ActiveRecord::Base

  # Validations
  validates :title, 
            :user_id, 
            :hoa_id, 
            :progress, 
            presence: true

  # public_activity -> set current_user as owner by default
  # only track creation events
  include PublicActivity::Model
  tracked only: [:create], 
    owner:  Proc.new{ |controller, model| controller && controller.current_user }, 
    hoa_id: Proc.new{ |controller, model| controller && controller.current_user.hoa.id }

  # active_admin
  resourcify

  # Acts as taggable on
  # preserve order so that in state, the last is the current state
  acts_as_ordered_taggable # Alias for acts_as_taggable_on :tags
  acts_as_ordered_taggable_on :state

  # Comments
  acts_as_commentable

  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: :assignee_id
  belongs_to :hoa
  
  has_many :collaborations, as: :collaborable
  has_many :readings, as: :readable

  def new?
    self.progress == 'new'
  end

  def in_progress?
    self.progress == 'in progress'
  end

  def completed?
    self.progress == 'completed'
  end

  def unread?(user)
    self.readings.find_by(user: user)
  end

  def mark_as_read!(user)
    self.readings << user
  end

  def self.unread_by(user)
    Reading.where(user: user, readable_type: 'Alert')
  end
end
