FactoryGirl.define do
  factory :user do
    email "admin@medusdf.com"
    password "password"
  end

  factory :admin, :class => User do
    email "admin@medu.com"
    password "passwords"
  end

  factory :other, :class => User do
    email "admin@medua.com"
    password "password"
  end
end
