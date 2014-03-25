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
#

class Alert < ActiveRecord::Base
  include PublicActivity::Model

  # public_activity -> set current_user as owner by default
  # only track creation events
  tracked only: :create, owner: Proc.new{ |controller, model| controller && controller.current_user }

  # active_admin
  resourcify
  
  belongs_to :user
  belongs_to :hoa
end
