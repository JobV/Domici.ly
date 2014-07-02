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
#  address           :string(255)
#  city              :string(255)
#  postal_code       :string(255)
#  kvk               :string(255)
#  account_nr        :string(255)
#  account_owner     :string(255)
#

class Hoa < ActiveRecord::Base
  validates :name, :subdomain_name, presence: true
  validates :subdomain_name, uniqueness: true

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
