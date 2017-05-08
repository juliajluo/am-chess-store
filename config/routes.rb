Rails.application.routes.draw do

  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices
  resources :users
  resources :sessions
  resources :orders
  # resources :cart

  #cart methods
  get 'viewcart' => 'cart#viewcart', as: :viewcart #this create a viewcart_path
  get 'add_to_cart/:id' => 'cart#add_to_cart', as: :add_to_cart #this creates a add_to_cart_path
  get 'remove_item/:id' => 'cart#remove_item', as: :remove_item
  get 'clear' => 'cart#clear', as: :clear
  get 'checkout' => 'cart#checkout', as: :checkout

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'signup' => 'users#new', :as => :signup
  # Set the root url
  root :to => 'home#home'

end
