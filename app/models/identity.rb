class Identity < ActiveRecord::Base
  belongs_to :user

  def self.find_with_omniauth(auth)
    find_by(provider: auth['provider'], uid: auth['uid'])
  end

  def create_with_omniauth(auth)
    create(uid: auth['uid'], provider: auth['provider'], oauth_token: auth.credentials.token)
  end
end
