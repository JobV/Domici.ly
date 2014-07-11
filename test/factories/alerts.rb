# == Schema Information
#
# Table name: alerts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :text
#  severity    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  hoa_id      :integer
#  progress    :string(255)      default("new")
#  assignee_id :integer
#  archived    :boolean          default(FALSE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert do
    title "Gat in muur, ergens."
    body "Er is een gat ergens."
    user
    hoa
  end

  factory :seq_alert, class: 'Alert' do
    sequence(:title) { |n| "lamp#{n} stuk" }
    sequence(:body)  { |n| "lamp#{n} stuk op verdieping#{n}" }
    user
    hoa
  end
end
