# Home Owners Association, smartass.

class Hoa < ActiveRecord::Base
  has_many :posts
  has_many :alerts
  has_many :users
end
