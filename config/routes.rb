Rails.application.routes.draw do
  devise_for :users

  get 'site/sha', to: 'site#sha'

  root 'welcome#index'

  get 'bago', to: 'register#index'
  get 'registration/search', to: 'registration#search'
  get 'registration/create_contact', to: 'registration#create_contact'
  post 'registration/confirm', to: 'registration#confirm'

  resources :domains, only: [:index, :show, :update] do
    get :renew
    resources :hosts, controller: :domain_hosts, only: [:create, :destroy], id: /.*/
  end

  resources :hosts, only: [:index, :show]

  resources :contacts, only: [:index, :show]

  resources :profile, only: :index

  resources :partners, only: [:index, :show] do
    get :otc, controller: :credits, action: :new
    post :otc, controller: :credits, action: :create
  end

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

  get   :register, to: 'register#new'
  post  :register, to: 'register#search'

  scope path: :register, as: :register do
    get   :registrant,  to: 'register#registrant'
    post  :registrant,  to: 'register#create'
  end

  resources :checkout, only: [:index] do
    collection do
      get :payment_token
      get :verify
    end
  end

  resources :credits, only: [:create]
end
