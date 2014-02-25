# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert do
    title "MyString"
    body "MyText"
    severity "MyString"
  end
end
