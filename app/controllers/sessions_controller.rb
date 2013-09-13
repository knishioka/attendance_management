class SessionsController < ApplicationController
  def create
    # @identity =  Identity.find_with_omniauth(auth_hash) || Identity.create_with_omniauth(auth_hash)
    if @identity = Identity.find_with_omniauth(auth_hash)
      if current_user
        current_user.identities.build.create_with_omniauth(auth_hash)
      else
        session[:user_id] = @identity.user.id
      end
    else
      if current_user
        current_user.create_identity(auth_hash)
      else
        @user = User.create_with_omniauth(auth_hash)
        @user.create_identity(auth_hash)
        session[:user_id] = @user.id
      end
    end
    redirect_to root_url
  end

  def logout
    reset_session
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
