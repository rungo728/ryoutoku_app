class MessagesController < ApplicationController
  before_action :get_user
  # イベントの仮情報を入れるまではコメントアウト
  before_action :set_event

  def index
    @message = Message.new
    # イベントに所属する全てのメッセージである@messagesを定義
    @messages = @event.messages.includes(:user)
  end

  def create
    if Entry.where(:user_id => current_user.id, :event_id => params[:message][:event_id]).present?
      @message = Message.create(message_params)
      # redirect_to "/events/#{@message.event_id}"
      binding.pry
    else
      redirect_back(fallback_location: root_path)
    end
    if @message.save
      # 本来はevent_messages_path seedでイベントの仮情報を入れたら変更
      redirect_to event_messages_path(@event), notice: 'メッセージが送信されました'
    else
      @messages = @event.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end
  
  private

  def message_params
    params.require(:message).permit(:user_id, :content, :image, :event_id).merge(user_id: current_user.id)
  end  

  def get_user
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
    end
  end
  # messagesコントローラの全てのアクションで@eventを利用できるようになる
  def set_event
    @event = Event.find(params[:event_id])

  end
end
