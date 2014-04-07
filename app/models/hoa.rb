# == Schema Information
#
# Table name: hoas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Home Owners Association, smartass.

class Hoa < ActiveRecord::Base
  resourcify

  has_many :posts
  has_many :alerts
  has_many :users
  has_many :events
end
