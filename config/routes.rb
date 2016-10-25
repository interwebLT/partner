Rails.application.routes.draw do
  devise_for :users

  get 'site/sha', to: 'site#sha'
  post 'transaction', to: 'checkout#transaction'
  get 'invoice', to: 'checkout#invoice'
  get 'receipt', to: 'checkout#receipt'
  get 'dns' => 'domain_hosts#dns'
  root 'welcome#index'

  get 'zendesk' => 'welcome#zendesk'

  get 'registration/search', to: 'registration#search'
  get 'registration/create_contact', to: 'registration#create_contact'
  post 'registration/confirm', to: 'registration#confirm'

  post 'contacts/:id/multiple', to: 'contacts#edit_multiple', as: 'edit_multiple_contacts'
  post 'domains/:id/multiple', to: 'domains#renew_multiple', as: 'renew_multiple_domains'

  get 'domains/:id/default_nameservers', to: 'domain_hosts#add_default_nameservers', as: 'add_default_nameserver'

  get 'domains/check_ns_authorization', to: 'domains#check_ns_authorization'
  get 'domains/check_if_exists',        to: 'domains#check_if_exists'

  get  'profile/partner_name_server',   to: 'profile#new'    , as: 'new_profile_partner_name_server'
  post 'profile/partner_name_server',   to: 'profile#update_partner_nameserver'

  get  'hosts/get_host_address', to: 'hosts#get_host_address'

  get 'domains/renewal_validation', to: 'domains#renewal_validation'

  get 'powerdns/records/check_if_exists', to: 'powerdns/records#check_if_exists'

  resources :domains, only: [:index, :show, :update], id: /.*/ do
    get :renew
    resources :hosts, controller: :domain_hosts, only: [:index, :create, :edit, :update, :destroy], id: /.*/
    resources :transfers, only: [:update, :destroy]
  end

  resources :transfers, only: [:new, :create]

  resources :hosts, only: [:index, :show]

  resources :contacts

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

  namespace :powerdns do
    resources :records
    resources :domains
  end

  get   :register, to: 'register#new'
  post  :register, to: 'register#search'

  scope path: :register, as: :register do
    get   :details, to: 'register#details'
    post  :details, to: 'register#create_registrant'

    get   :summary, to: 'register#summary'
    post  :summary, to: 'register#create_order'
  end

  resources :checkout, only: [:index] do
    collection do
      get :payment_token
      get :verify
    end
  end

  scope path: :paypal, as: :paypal do
    post :setup_payment, to: 'paypal#setup_payment'
    match :return, to: 'paypal#returns', via: [:get, :post]
    match :cancel, to: 'paypal#cancel', via: [:get, :post]
  end

#  resources :credits, only: [:create]
  scope path: :credits do
    match '/', to: 'credits#create', via: [:get, :post], as: :credits
  end

  scope path: :dragon_pay, as: :dragon_pay do
    post :setup_payment, to: 'dragon_pay#setup_payment'
    get :pending, to: 'dragon_pay#pending'
  end
end
