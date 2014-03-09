include FactoryGirl::Syntax::Methods

FactoryGirl.define do

  factory :user do
    first_name 'John'
    last_name 'Doe'
    email 'test@new.com'
    password 'jobiscool'
    password_confirmation 'jobiscool'
  end

  factory :board_member, class: User do
    first_name 'John'
    last_name 'Doe'
    email 'board@member.com'
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

  factory :post do
    title 'nieuwsbrief januari'
    body 'This is the body of the post.'
  end
end
