# Home Owners Association, smartass.

class Hoa < ActiveRecord::Base
  has_many :posts
  has_many :alerts
  has_many :users

  has_and_belongs_to_many :board_members, class_name: 'User', foreign_key: 'user_id'
  
end
