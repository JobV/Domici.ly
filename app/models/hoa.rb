# == Schema Information
#
# Table name: hoas
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  subdomain_name :string(255)
#

# Home Owners Association, smartass.

class Hoa < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  resourcify

  has_many :posts
  has_many :alerts
  has_many :users
  has_many :events
  has_many :announcements
  has_one :homepage

  def subscription
    subscription_type == 'standaard' ? 'Standaard' : 'Basis'
  end

  # WIP
  def subscribed?
    subscribed_until
  end
end
