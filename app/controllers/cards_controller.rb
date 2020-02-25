class CardsController < ApplicationController
  
  require "payjp" 
  before_action :set_card

  def new
    # cardがすでに登録済みの場合、showのページに戻します。
    @card = Card.where(user_id: current_user.id).first
    redirect_to action: "show" if @card.present?    
  end

  def pay
    # payjpとCardのデータベースを作成する
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    # jsで作成したpayjpTokenがちゃんと入っているか？
    if params['payjp-token'].blank?
      binding.pry
      redirect_to action: "new"
    else
      # トークンがちゃんとあれば進めて、PAY.JPに登録されるユーザーを作成します。
      customer = Payjp::Customer.create(
      description: '登録テスト',  # なくてもOK
      email: current_user.email, # なくてもOK
      # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存する
      card: params['payjp-token'],
      metadata: {user_id: current_user.id} # なくてもOK
      )
      # PAY.JPのユーザーが作成できたので、cardモデルを登録します。
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      @card.save
      binding.pry
      if @card.save
        redirect_to cards_path, notice: '登録が完了しました'

      else
        redirect_to action: "pay"
      end
    end
  end

  def show

    # すでにクレジットカードが登録しているか？  
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
      # クレジットカード会社を取得したので、カード会社の画像をviewに表示させるため、ファイルを指定する。
      case @card_brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master-card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "dinersclub.svg"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end


