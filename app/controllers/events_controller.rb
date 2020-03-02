class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :get_user
  before_action :set_event,only: [:edit, :update]

  def index
    #カテゴリーごとに並べる
    @meats = Event.includes(:images).where(category_id: 158..247).order("updated_at DESC").limit(10)
    @rices = Event.includes(:images).where(category_id: 275..342).order("updated_at DESC").limit(10)
    @breads = Event.includes(:images).where(category_id: 580..648).order("updated_at DESC").limit(10)
    @sweets = Event.includes(:images).where(category_id: 649..763).order("updated_at DESC").limit(10)
    if user_signed_in?
      # ログインユーザが持っている複数のentryをEntryテーブルから探して変数にいれます
      @entries = Entry.where(user_id: current_user.id)
      myEventIds = []
      # myEventIdsにログインユーザが持っているそれぞれのentryにおけるeventのid情報を渡す
      @entries.each do | entry |
        myEventIds << entry.event.id
      end
      @anotherEntries = Entry.where(event_id: myEventIds).where('user_id != ?', @user.id).order("updated_at DESC").limit(10)
    end
  end

  def create
    @event = Event.new(event_params)
    @event.save
    if @event.save
      redirect_to root_path, notice: '出展が完了しました'
    else
      redirect_to new_event_path, alert: '出展が完了しておりません'
    end
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
    @user = User.find_by(id: @event.exhibitor_id)
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
    @entry = Entry.new
    @card = Card.where(user_id: current_user.id).first
    if @card.present?
      # 登録している場合,PAY.JPからカード情報を取得する
      # PAY.JPの秘密鍵をセットする。
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      # PAY.JPから顧客情報を取得する。
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
      @card_info = customer.cards.retrieve(@card.card_id)
      # クレジットカード情報から表示させたい情報を定義する。
      # クレジットカードの画像を表示するために、カード会社を取得
      @card_brand = @card_info.brand
      # クレジットカードの有効期限を取得
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3)
    end
  end

  # イベント予約の為にpayjpへ決済情報とトークンを送る際の定義を記述
  def buy
    @event = Event.find(params[:id])
    @entry = Entry.new(:event_id => @event.id, :user_id => current_user.id)
    binding.pry
    @entry.save
    @card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    # 請求を発行
    charge = Payjp::Charge.create(
    amount: @event.price,#支払金額
    # customer:  @card.customer_id,#顧客ID
    card: params['payjp-token'],
    currency: 'jpy'
    )
    redirect_to action: :done
  end

  # イベント予約完了画面
  def done
    @event = Event.find(params[:id])
    @entries = Entry.where(event_id: @event.id).count
    binding.pry
    if @entries == @event.capacity
      @event_buyer = Event.find(params[:id])
      @event_buyer.update(buyer_id: current_user.id)
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :capacity,:place,:price,:prefecture_id,:category_id, images_attributes: [:id, :event_id, :content, :_destroy ]).merge(exhibitor_id: current_user.id)
    #開催場所・日時・料理工程ページ作成したらpermitに入れる
    # ,address_attributes: [:id, :event_id, :date, :time, :postcode,:city,:address,:building,:phone_number,:figure],cook_attributes: [:id,:event_id,:level1,:level2,:level3,:level4,:level5]
  end

  def get_user
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
    end
  end



  def entry_params
    params.require(:entry).permit(:user_id, :event_id).merge(event_id: @event.id)
  end


  def set_event
    @event = Event.find(params[:id])
  end

end
