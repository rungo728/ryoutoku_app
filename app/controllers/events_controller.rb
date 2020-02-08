class EventsController < ApplicationController
  before_action :get_user
  before_action :set_event,only: [:edit, :update]

  def index
    
  end
  # イベント出展画面
  def new
    @event = Event.new
    @event.users << current_user
  end

  # イベント詳細画面
  def show
    
    @event = Event.find(params[:id])
    @user = User.find_by(id: @event.exhibitor_id)
  end

  # イベント予約確認画面
  def confirmation
    @event = Event.find(params[:id])
  end

  private

  def get_user
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
