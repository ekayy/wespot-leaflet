# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    place_id 1
    url "MyString"
    title "MyString"
    snippet "MyString"
    image "MyString"
  end
end
