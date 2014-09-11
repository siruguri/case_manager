# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_action do
    description "MyString"
    user_id 1
  end
end
