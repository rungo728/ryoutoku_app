class EventsController < ApplicationController

  def index
    
  end

  def new
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(current_user.id)
  end
end
