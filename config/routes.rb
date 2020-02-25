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
      post 'buy'
      get 'done'
    end
    # seedで仮情報をイベントテーブルに入れたらこの位置に記述を移す
    resources :messages
  end

  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end

     
  resources :users, only: [:show, :edit] do
    collection do
      post 'show', to: 'users#show'
    end
  end
end
