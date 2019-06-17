Rails.application.routes.draw do
  resources :rents
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :searches
  resources :microposts
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  # root 'static_pages#home'
  root 'microposts#index'
  get  '/home',    to: 'microposts#index', as: 'helf'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/postnew', to: 'microposts#new'
  get  '/usershow', to: 'users#show'

  get  '/signup', to: 'users#new'
  get    '/login',   to: 'session#new'
  get    '/activation',   to: 'account_activations#new'
  post   '/login',   to: 'session#create'
  delete '/logout',  to: 'session#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
