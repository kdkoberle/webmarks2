FactoryGirl.define do
  factory :user do
    username     "Mhat-dude"
    fullname     "Michael Hartl"
    email    "michael@example.com"
    password "foobars"
    password_confirmation "foobars"
  end
end