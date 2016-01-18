class Meetup < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  has_many :users_meetups, dependent: :destroy
  has_many :users
  has_many :users, through: :users_meetups

  validates :name, presence: true
  validates :description, presence: true, length: { minumum: 5, maximum: 200 }
  validates :location, length: { minimum: 3 }, allow_blank: true
end
