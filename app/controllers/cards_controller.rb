class CardsController < ApplicationController
  
  require "payjp" 

  def new
    card = Card.where(user_id: current_user.id)
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
    
  end
end
