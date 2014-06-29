# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reading do
    readable_id 1
    user_id 1
    readable_type "MyString"
  end
end
