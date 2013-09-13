class User < ActiveRecord::Base
  has_many :identities

  def self.create_with_omniauth(auth)
    create(name: auth.info.name)
  end

  def create_identity (auth)
    identities.build(uid: auth['uid'], provider: auth['provider'], oauth_token: auth.credentials.token).save!
  end
end
