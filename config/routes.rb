Rails.application.routes.draw do
  devise_for :users

  get 'site/sha', to: 'site#sha'
  patch '/contacts/handle' => 'domains#update'

  root 'welcome#index'

  resources :domains, only: [:index, :show] do
    get :renew
  end

  resources :profile, only: :index

  resources :partners, only: [:index, :show]

  resources :reports, only: :index

  resources :about, only: [] do
    collection do
      get :coc
      get :sa
    end
  end

  resources :partner, only: [:index]

  resources :activities, only: [:index]

  resources :orders, only: [:index]
end
