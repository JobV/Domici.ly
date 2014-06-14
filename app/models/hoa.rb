# == Schema Information
#
# Table name: hoas
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  subdomain_name    :string(255)
#  subscription_type :string(255)      default("basic")
#  subscribed_until  :datetime
#

class Hoa < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  resourcify

  has_many :posts
  has_many :alerts
  has_many :users
  has_many :events
  has_many :announcements
  has_many :payments
  has_one :homepage

  def subscription
    subscription_type == 'standard' ? 'Standaard' : 'Basis'
  end

  def subscribed?
    subscribed_until &&
    subscribed_until > DateTime.now &&
    subscription_type == 'standard'
  end
end
