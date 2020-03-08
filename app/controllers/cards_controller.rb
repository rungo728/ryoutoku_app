class CardsController < ApplicationController
  
  require "payjp" 
  # before_action :set_card

  def new
    # cardがすでに登録済みの場合、showのページに戻します。
    @card = Card.new
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
      # description: '登録テスト',  # なくてもOK
      # email: current_user.email, # なくてもOK
      # metadata: {user_id: current_user.id} # なくてもOK
      # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存する
      card: params['payjp-token']
      
      )
      # PAY.JPのユーザーが作成できたので、cardモデルを登録します。
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      @card.save
      if @card.save
        redirect_to cards_path, notice: '登録が完了しました'

      else
        redirect_to action: "pay"
      end
    end
  end

  def show
    @card = Card.where(user_id: current_user.id).first
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
      # カードブランドうまく分けられる様になったらコメントアウト外す
      # case @card_brand
      # when "Visa"
      #   @card_image = "visa.svg"
      # when "JCB"
      #   @card_image = "jcb.svg"
      # when "MasterCard"
      #   @card_image = "master-card.svg"
      # when "American Express"
      #   @card_image = "american_express.svg"
      # when "Diners Club"
      #   @card_image = "dinersclub.svg"
      # when "Discover"
      #   @card_image = "discover.svg"
      # end
    end
  end

  def delete
    # 今回はクレジットカードを削除するだけでなく、PAY.JPの顧客情報も削除する。これによりpayメソッドが複雑にならない。
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報をする。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # PAY.JPの顧客情報を取得
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete # PAY.JPの顧客情報を削除
    if @card.destroy # App上でもクレジットカードを削除
      redirect_to users_path, notice: "削除しました"
    else
      redirect_to users_path, alert: "削除できませんでした"
    end
  end

  private

  # def set_card
  #   @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  # end
end


