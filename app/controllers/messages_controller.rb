class MessagesController < ApplicationController
  before_action :get_event

  def index
    
  end

  
  private

  def get_event
    @user = User.find(current_user.id)
  end
end
