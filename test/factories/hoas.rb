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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hoa do
    sequence(:name) {|n| "vve#{n}" }
    sequence(:subdomain_name) {|n| "vve#{n}" }
  end
end
