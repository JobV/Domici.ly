# == Schema Information
#
# Table name: announcements
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  body         :text
#  hoa_id       :integer
#  user_id      :integer
#  target_group :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Announcement < ActiveRecord::Base
  validates :title, :body, presence: true
  belongs_to :hoa
  belongs_to :user
end
