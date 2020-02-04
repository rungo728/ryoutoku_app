Rails.application.routes.draw do
  devise_for :users
  # 仮のルーティング
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    collection do
      get 'confirmation', to: 'events#confirmation'
      resources :messages
    end
    # seedで仮情報をイベントテーブルに入れたらこの位置に記述を移す
    # resources :messages
  end

  resources :exhibits do    
  end

     
  resources :users do
    
  end
end
