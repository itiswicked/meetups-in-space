# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'faker'
require 'factory_girl'

### MEETUPS ###


meetups = ["Tampflex", "Konklux", "Y-find", "Voyatouch", "Duobam"]
descriptions = ["Corrupti illum quis dolor sunt ipsam similique. Placeat facilis ut magnam hic excepturi sed. Sunt labore et. Quidem quod et itaque voluptates tempore enim.",
 "Aspernatur ipsam deserunt perspiciatis est voluptatem labore architecto. Sequi reprehenderit sint sint. Earum sapiente provident enim. Nam distinctio voluptates nesciunt et sed. Non enim est.",
 "Et animi quia. Quisquam et accusantium culpa. Assumenda tempora voluptatem voluptas porro consequuntur.",
 "Aut aut consequatur quis et dignissimos. Atque accusamus autem aliquid. Quidem tempore aut consectetur eos quae aut expedita. Nisi rerum tenetur sint.",
 "Quo minima ratione corrupti architecto pariatur. Eaque nobis laborum optio sequi in. Et ipsam dolorem magni laborum ad ex. Laborum quia voluptatem. Quia provident accusantium similique iusto id."]

5.times do |i|
  Meetup.create(
    user_id: i + 1,
    name: meetups[i],
    description: descriptions[i]
  )
end

### USERS ###

10.times do |i|
  User.create(
    provider: 'github',
    uid: i + 2,
    username: "itiswicked#{i}",
    email: "nathanrbourke#{i}@gmail.com",
    avatar_url: "https://avatars3.githubusercontent.com/u/8851553?v=3&s=460#{i}"
  )
end

### JOIN TABLE ###

users_meetups = [
  {user_id: 1, meetup_id: 1 },
  {user_id: 2, meetup_id: 1 },
  {user_id: 3, meetup_id: 2 },
  {user_id: 4, meetup_id: 2 },
  {user_id: 5, meetup_id: 3 },
  {user_id: 6, meetup_id: 3 },
  {user_id: 7, meetup_id: 4 },
  {user_id: 8, meetup_id: 4 },
  {user_id: 9, meetup_id: 5 },
  {user_id: 10, meetup_id: 5 }
]

users_meetups.each do |user_meetup|
  UsersMeetup.create(user_meetup)
end








### FACTORY GIRL TEST ###

FactoryGirl.define do
  factory :user do
    provider 'github'
    sequence(:uid) { |n| "#{n+1}" }
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    avatar_url Faker::Internet.url
  end

  factory :meetup do
  end
end
