# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :datetime
#  title       :string(255)
#  location    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  hoa_id      :integer
#  description :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    date "2014-04-04 20:59:53"
    title "MyString"
    location "MyString"
    hoa
    user
  end
end
