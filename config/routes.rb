Rails.application.routes.draw do
  devise_for :users
  # 仮のルーティング
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    collection do
      get 'events/get_category_children', defaults: { format: 'json' }
      get 'events/get_category_grandchildren', defaults: { format: 'json' }
      # get 'confirmation'
      # resources :messages
    end
    member do
      get 'confirmation'
    end
    # seedで仮情報をイベントテーブルに入れたらこの位置に記述を移す
    resources :messages
  end

  resources :exhibits do    
  end

     
  resources :users do
    
  end
end
