class HomeController < ApplicationController
  def index
    unless current_user
      render :welcome
      return
    end
    @attendances = current_user.attendances
    logger.debug current_user.inspect
    logger.debug @attendances.inspect
  end
end
