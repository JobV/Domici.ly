# == Schema Information
#
# Table name: homepages
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  subdomain_name :string(255)
#  hoa_id         :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :homepage do
    subdomain_name 'jaxons'
  end
end
