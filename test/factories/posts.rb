# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  hoa_id     :integer
#

include FactoryGirl::Syntax::Methods

FactoryGirl.define do
  factory :post do
    title 'nieuwsbrief januari'
    body 'This is the body of the post.'
    user
    hoa
  end
end
