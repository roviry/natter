FactoryGirl.define do
    factory :user do
        sequence(:name) { |n| "Person #{n}" }
        sequence(:email) { |n| "person_#{n}@castingspider.com" }
        password "pilot99"
        password_confirmation "pilot99"

    factory :admin do
        admin true
    end
    end
end