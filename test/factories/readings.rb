# == Schema Information
#
# Table name: readings
#
#  id            :integer          not null, primary key
#  readable_id   :integer
#  user_id       :integer          not null
#  readable_type :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reading do
    readable_id 1
    user_id 1
    readable_type "MyString"
  end
end
