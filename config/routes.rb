Rails.application.routes.draw do
  devise_for :users

  get 'site/sha', to: 'site#sha'

  root 'welcome#index'

  get 'domains/register/:name', to: 'domains#register', name: /.*/
  get 'domains/create_contact', to: 'domains#create_contact'
  post 'domains/confirm_registration', to: 'domains#confirm_registration'

  resources :domains, only: [:index, :show] do
    get :renew
    resources :hosts, controller: :domain_hosts, only: [:create, :destroy], id: /.*/
  end

  resources :hosts, only: [:index, :show]

  resources :contacts, only: [:index, :update, :show]

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

  resources :register, only: [:index]
end
