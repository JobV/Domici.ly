# == Schema Information
#
# Table name: alerts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  severity   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  hoa_id     :integer
#  state      :string(255)
#

class Alert < ActiveRecord::Base
  # public_activity -> set current_user as owner by default
  # only track creation events
  include PublicActivity::Model
  tracked only: :create, owner: Proc.new{ |controller, model| controller && controller.current_user }

  # active_admin
  resourcify

  # Acts as taggable on
  # preserve order so that in state, the last is the current state
  acts_as_ordered_taggable # Alias for acts_as_taggable_on :tags
  acts_as_ordered_taggable_on :state

  # unread gem
  acts_as_readable on: :created_at

  belongs_to :user
  belongs_to :hoa

  def new?
    progress == 'new'
  end

  def in_progress?
    progress == 'in progress'
  end

  def completed?
    progress == 'completed'
  end
end
