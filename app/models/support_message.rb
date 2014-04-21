# == Schema Information
#
# Table name: support_messages
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  hoa_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class SupportMessage < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :user
  belongs_to :hoa
end
