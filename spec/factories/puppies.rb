# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :puppy do
    orientation 'hor'
    disabled false

    factory :disabled_puppy do
      disabled true
    end
  end
end