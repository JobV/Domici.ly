# == Schema Information
#
# Table name: collaborations
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  collaborable_id   :integer
#  collaborable_type :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collaboration do
    user_id 1
  end
end
