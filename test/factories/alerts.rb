# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert do
    title "Gat in muur, ergens."
    body "Er is een gat ergens."
    severity "high"
  end
end
