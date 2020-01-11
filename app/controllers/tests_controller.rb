class TestsController < ApplicationController

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
    end
  end
end
