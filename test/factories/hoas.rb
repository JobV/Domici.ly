# == Schema Information
#
# Table name: hoas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hoa do
    sequence(:name) {|n| "vve#{n}" }
  end
end
