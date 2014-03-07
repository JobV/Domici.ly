# This will guess the User class
FactoryGirl.define do
  factory :user do
    email 'john@doe.com'
    password 'jobiscool'
    password_confirmation 'jobiscool'
  end

  factory :board_member, class: User do
    email 'board@member.com'
    password 'jobiscool'
    password_confirmation 'jobiscool'
  end

  factory :post do
    title 'nieuwsbrief januari'
    body 'This is the body of the post.'
  end
end
