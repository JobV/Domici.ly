# == Schema Information
#
# Table name: payments
#
#  id          :integer          not null, primary key
#  amount      :integer
#  description :string(255)
#  order_id    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  paid        :boolean          default(FALSE)
#  payment_id  :string(255)
#  hoa_id      :integer
#  user_id     :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    amount 1
    description "MyString"
    order_id "MyString"
  end
end
