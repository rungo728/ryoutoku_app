class EventsController < ApplicationController
  before_action :get_event

  def index
    
  end
  # イベント出展画面
  def new
  end

  # イベント詳細画面
  def show
    
    # @event = Event.find(params[:id])
    # @user = User.find_by(id: @event.exhibitor_id)
  end

  # イベント予約確認画面
  def confirmation
    
  end

  private

  def get_event
    @user = User.find(current_user.id)
  end
end
