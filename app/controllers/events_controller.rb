class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :get_user
  before_action :set_event,only: [:edit, :update]

  def index
    @user_events = Event.where(exhibitor_id: @user.id).order("id DESC").limit(6)
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
    @event = Event.create(event_params)
    @event.save
    binding.pry
    if @event.save
      # redirect_to "/events/#{@event.id}"
      redirect_to root_path, notice: '出展が完了しました'
    end
      redirect_to new_event_path, alert: '出展が完了しておりません'
    # ↓別のコントローラに移動させる
    # @entry1 = Entry.create(:event_id => @event.id, :user_id => current_user.id)
    # @entry2 = Entry.create(params.require(:entry).permit(:user_id, :event_id).merge(:event_id => @event.id))
  end

  # イベント出展画面
  def new
    @event = Event.new
    @event.images.build
    # @event.build_address
    # @event.build_cook
    @parents = Category.where(ancestry: nil)
  end

  # 子カテゴリーidを取得するためのアクション
  def get_category_children
    #親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json { render 'new', json: @children }
    end
  end

  # 孫カテゴリーidを取得するためのアクション
  def get_category_grandchildren
    @grandchildren = Category.find(params[:child_id]).children
    respond_to do |format|
      format.html
      format.json { render 'new', json: @grandchildren}
    end
  end
  
  # イベント詳細画面
  def show
    @event = Event.find(params[:id])
    if Entry.where(:user_id => current_user.id, :event_id => @event.id).present?
      @messages = @event.messages.includes(:user)
      @message = Message.new
      @entries = @event.entries.includes(:user)
    else
      # redirect_back(fallback_location: root_path)

    end
  end

  # イベント予約確認画面
  def confirmation
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :capacity,:place,:price,:prefecture_id,:category_id, images_attributes: [:id, :event_id, {content:[]}, :_destroy ],address_attributes: [:id, :event_id, :date, :time, :postcode,:city,:address,:building,:phone_number,:figure],cook_attributes: [:id,:event_id,:level1,:level2,:level3,:level4,:level5]).merge(exhibitor_id: current_user.id)
  end

  def get_user
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
    end
  end



  # def entry_params
  #   params.require(:entry).permit(:user_id, :event_id).merge(:event_id => @event.id)
  # end


  def set_event
    @event = Event.find(params[:id])
  end

end
