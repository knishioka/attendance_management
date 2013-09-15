class User < ActiveRecord::Base
  has_many :identities
  has_many :attendances

  def self.create_with_omniauth(auth)
    create(name: auth.info.name)
  end

  def create_identity(auth)
    identities.build(uid: auth['uid'], provider: auth['provider'], oauth_token: auth.credentials.token).save!
  end

  def attend!(options)
    attendance = attendances.build(working_day: options[:working_day])
    begin
      attendance.update_attributes(working_time: options[:working_time], comment: options[:comment])
    end
    attendance
  end

  def destroy_attend!(attend_id)
    attendances.find(attend_id).try(:destroy)
  end
end
