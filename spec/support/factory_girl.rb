require 'factory_girl'

FactoryGirl.define do

  factory :user do
    provider "github"
    sequence(:uid) { |n| n }
    sequence(:username) { |n| "jarlax#{n}" }
    sequence(:email) { |n| "jarlax#{n}@launchacademy.com" }
    avatar_url "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
  end

  factory :meetup do
    name "Duck Gathering"
    description "A gathering of majestic fowl."
    location "Pond"
  end


  factory :comment do
    body "I hate that we go to the same pond every time."
  end
end
