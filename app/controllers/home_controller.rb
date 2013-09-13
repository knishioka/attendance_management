class HomeController < ApplicationController
  def index
    unless current_user
      render :welcome
      return
    end
  end
end
