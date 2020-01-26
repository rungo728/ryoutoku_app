Rails.application.routes.draw do
  devise_for :users
  # 仮のルーティング
  root 'tests#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    collection do
      get 'confirmation', to: 'events#confirmation'    
    end
  end

  resources :exhibits do    
  end

  resources :messages do
    
  end
  resources :users do
    
  end
end
