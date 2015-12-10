require 'json'

class User < ActiveRecord::Base
  has_many :users_meetups
  has_many :meetups, through: :users_meetups

  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.provider = provider
      user.uid = uid
      user.email = auth.info.email
      user.username = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

  def to_json
    { username: username, avatar_url: avatar_url, id: id }.to_json
  end
end
