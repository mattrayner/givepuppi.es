# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :puppy do
    orientation 'hor'
    disabled false
    image nil

    factory :disabled_puppy do
      disabled true
    end

    factory :puppy_with_image do
      image { fixture_file_upload(Rails.root.join('spec', 'photos', 'rails.jpg'), 'image/jpeg') }
    end
  end
end