FactoryGirl.define do
   factory :user do
     sequence(:email){|n| "user#{n}@factory.com" }
     password pw
     password_confirmation pw
     role :standard
   end
 end