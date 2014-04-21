# == Schema Information
#
# Table name: support_messages
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  hoa_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :support_message do
    body "MyText"
    user_id 1
    hoa_id 1
  end
end
