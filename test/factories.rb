# This will guess the User class
FactoryGirl.define do
  factory :user do
    email 'john@doe.com'
    password 'jobiscool'
    password_confirmation 'jobiscool'
  end

  factory :post do
    title 'nieuwsbrief januari'
    body 'This is the body of the post.'
  end
end
