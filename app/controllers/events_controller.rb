class EventsController < ApplicationController
  before_action :get_user
  before_action :set_event,only: [:edit, :update]

  def index
    if user_signed_in?
      @entries = Entry.where(user_id: current_user.id)
      myEventIds = []

      @entries.each do | entry |
        myEventIds << entry.event.id
      end
      @anotherEntries = Entry.where(event_id: myEventIds).where('user_id != ?', @user.id)
    end
  end

  def create
    @event = Event.create
    @entry1 = Entry.create(:event_id => @event.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :event_id).merge(:event_id => @event.id))
    if @event.save
      redirect_to "/events/#{@event.id}"
    end

  end

  # イベント出展画面
  def new
    @event = Event.new
    @event.users << current_user
  end

  # イベント詳細画面
  def show
    @event = Event.find(params[:id])
    if Entry.where(:user_id => current_user.id, :event_id => @event.id).present?
      @messages = @event.messages.includes(:user)
      @message = Message.new
      @entries = @event.entries.includes(:user)
    else
      redirect_back(fallback_location: root_path)
    end
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
