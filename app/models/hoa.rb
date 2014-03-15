# Home Owners Association, smartass.

class Hoa < ActiveRecord::Base
  resourcify

  has_many :posts
  has_many :alerts
  has_many :users
end
