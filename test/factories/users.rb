# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean
#  first_name             :string(255)
#  last_name              :string(255)
#  hoa_id                 :integer
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  address                :string(255)
#  house_number           :string(255)
#  postal_code            :string(255)
#  phone_number           :string(255)
#  city                   :string(255)
#

include FactoryGirl::Syntax::Methods

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    address 'Badhuisweg'
    house_number '1'
    postal_code '1506PA'
    phone_number '0612345678'
    sequence(:email) { |n| "test#{n}@new.com" }
    password 'jobiscool'
    password_confirmation 'jobiscool'
    hoa
  end

  factory :board_member, class: User do
    first_name 'John'
    last_name 'Doe'
    email 'board@member.com'
    password 'jobiscool'
    password_confirmation 'jobiscool'
  end

  factory :user_without_hoa, class: User do
    first_name 'John'
    last_name 'Doe'
    sequence(:email) { |n| "test_no_hoa@new.com" }
    password 'jobiscool'
    password_confirmation 'jobiscool'
  end

  factory :admin, class: User do
    first_name 'John'
    last_name 'Doe'
    email 'admin@admin.com'
    password 'jobiscool'
    password_confirmation 'jobiscool'
    admin true
  end
end
