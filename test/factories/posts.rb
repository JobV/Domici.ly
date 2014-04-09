include FactoryGirl::Syntax::Methods

FactoryGirl.define do
  factory :post do
    title 'nieuwsbrief januari'
    body 'This is the body of the post.'
    user
    hoa
  end
end
