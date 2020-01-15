class EventsController < ApplicationController
  before_action :get_event

  def index
    
  end

  def new

  end

  def show

  end

  def confirmation
    
  end

  private

  def get_event
    @user = User.find(current_user.id)
  end
end
