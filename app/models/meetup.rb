class Meetup < ActiveRecord::Base
  belongs_to :user
  has_many :users_meetups
  has_many :users
  has_many :users, through: :users_meetups
end
