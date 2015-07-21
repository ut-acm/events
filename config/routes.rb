Rails.application.routes.draw do

  resources :ut_students

  resources :coupons

  get 'events/search' => 'events#search'

  resources :reports

  mount Ckeditor::Engine => '/ckeditor'
  resources :answers

  resources :surveys

  resources :worldcups

  resources :price_models

  get 'validate_ut/:token'=>'ut_students#validate',:as=>:validate_ut_email

  get 'payments/approve' => 'payments#approve'
  get 'payments/manual_new' => 'payments#manual_new'
  post 'payments/manual_new' => 'payments#manual_create'
  put 'payments/manual_approve/:id' => 'payments#manual_approve'
  resources :payments

  get 'participations' => 'events#participation_index'
  post 'participations/buy/:id' => 'events#manual_buy'

  get  'participations/new' => 'events#participation_new'
  post 'participations/create' => 'events#participation_create'
  delete 'participations/destroy/:id' => 'events#participation_destroy'


  resources :invoices

  resources :officerships

  #get 'events/index'
  #
  #get 'events/show'
  #
  #get 'events/new'
  #
  #get 'events/edit'

  get 'category/:category' => 'events#filter_by_category'
  get 'year/:year' => 'events#filter_by_year' , :as => :filter_by_year

  match 'user_import/import_users' ,to: 'user_import#import_users' ,via: :post

  get 'admin' => 'events#admin_index'

  root 'events#index'

  get 'coupons_by_price_model/:price_model_id', to: 'coupons#filter_by_price'

  devise_for :users, path: 'auth', path_names: {sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'new'}, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  # get 'live'=>'live#choose' => :as=>:live_choose

  get 'events/prebuy/:event' => 'events#prebuy', :as => :prebuy
  post 'buy' => 'events#buy', :as => :buy
  match 'temp_start_all' => 'events#temp_start_all', :as => :temp_start_all, :via => :get
  resources :events do
    member do
      resources :class_sessions
      match 'book' => 'events#book', :as => :book, :via => :post
      match 'book_conference' => 'events#book_conference',:as=>:book_conference, :via => :post
      match 'cancel' => 'events#cancel_book', :as => :cancel_book, :via => :delete
      match 'cancel_conference' => 'events#cancel_book_conference', :as => :cancel_book_conference, :via => :delete
      match 'start_register' => 'events#start_register', :as => :start_register, :via => :get
      match 'check_token/:token'=>'events#check_token', :as=>:check_token,:via=>:get
    end
  end
  resources :profiles
  
end
