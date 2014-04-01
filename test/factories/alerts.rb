# == Schema Information
#
# Table name: alerts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  severity   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  hoa_id     :integer
#  state      :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert do
    title "Gat in muur, ergens."
    body "Er is een gat ergens."
    severity "high"
    user
  end
end
