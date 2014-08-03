# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname 'Matt'
    surname 'Rayner'
    email 'matt@givepuppi.es'
    password 'password'
    admin false

    factory :admin_user do
      admin true
    end
  end
end