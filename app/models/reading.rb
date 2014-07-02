# == Schema Information
#
# Table name: readings
#
#  id            :integer          not null, primary key
#  readable_id   :integer
#  user_id       :integer          not null
#  readable_type :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Reading < ActiveRecord::Base
  belongs_to :readable, polymorphic: true
  belongs_to :user

  validates :user, presence: true, uniqueness: { scope: :readable }
end
