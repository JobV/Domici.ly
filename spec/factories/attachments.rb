# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  alert_id   :integer
#  attachment :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    alert_id 1
    attachment "MyString"
  end
end
