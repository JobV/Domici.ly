# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  hoa_id     :integer
#

class Post < ActiveRecord::Base
  # Public Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller && controller.current_user }, hoa_id: Proc.new{ |controller, model| controller && controller.current_user.hoa.id }

  # Associations
  belongs_to :user
  belongs_to :hoa
end
