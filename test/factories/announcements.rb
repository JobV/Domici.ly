# == Schema Information
#
# Table name: announcements
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  body         :text
#  hoa_id       :integer
#  user_id      :integer
#  target_group :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    title "MyString"
    body "MyText"
    target_group "everyone"
    user
    hoa
  end

  factory :announcement_to_moderators, class: Announcement do
    title "MyString"
    body "MyText"
    target_group "moderators"
    user
    hoa
  end

  factory :announcement_to_no_one, class: Announcement do
    title "MyString"
    body "MyText"
    target_group ""
    user
    hoa
  end
end
