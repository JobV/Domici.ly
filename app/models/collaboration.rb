# == Schema Information
#
# Table name: collaborations
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  collaborable_id   :integer
#  collaborable_type :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Collaboration < ActiveRecord::Base
  belongs_to :collaborable, polymorphic: true
  belongs_to :user

  validates :user, presence: true, uniqueness: { scope: :collaborable }
end
