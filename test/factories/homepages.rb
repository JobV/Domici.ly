# == Schema Information
#
# Table name: homepages
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  subdomain_name :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :homepage do
  end
end
