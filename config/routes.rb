Rails.application.routes.draw do
  resources :posts do
    resources :comments do
      member do
        post :publish
      end
    end
  end

  root 'posts#index'

  resources :authors, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
