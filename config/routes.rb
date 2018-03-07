Rails.application.routes.draw do
  # devise_for :chefs
  devise_for :chefs, :controllers => { :registrations => 'registrations' }
  # root 'welcome#index'

  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  #resources :recipes
  #get '/recipes', to: 'recipes#index'
  #get '/recipes/new', to: 'recipes#new', as: 'new_recipe' 
  #get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  
  resources :recipes do
    resources :comments, only: [:create]
  end
  
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  
  get '/login', to: 'sessions#new'
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"  
  
  get '/signup2', to: 'chapters#chapter1_1'
  
  resources :ingredients, except: [:destroy]
  
  mount ActionCable.server => '/cable'
  get '/chat', to: 'chatrooms#show'
  
  resources :messages, only: [:create]
  
  get '/chapter1_1', to: 'chapters#chapter1_1'
  get '/chapter1_2', to: 'chapters#chapter1_2'
  get '/chapter1_3', to: 'chapters#chapter1_3'
  get '/chapter1_4', to: 'chapters#chapter1_4'
  
  get '/chapter2_1', to: 'chapters#chapter2_1'
  get '/chapter2_2', to: 'chapters#chapter2_2'
  get '/chapter2_3', to: 'chapters#chapter2_3'
  
  get '/chapter3_1', to: 'chapters#chapter3_1'
  get '/chapter3_2', to: 'chapters#chapter3_2'
  
  get '/chapter4_1', to: 'chapters#chapter4_1'
  get '/chapter4_2', to: 'chapters#chapter4_2'
  get '/chapter4_3', to: 'chapters#chapter4_3'
  get '/chapter4_4', to: 'chapters#chapter4_4'
  get '/chapter4_5', to: 'chapters#chapter4_5'
  
  get '/chapter5_1', to: 'chapters#chapter5_1'
  get '/chapter5_2', to: 'chapters#chapter5_2'
  
  get '/chapter6_1', to: 'chapters#chapter6_1'
  get '/chapter6_2', to: 'chapters#chapter6_2'
  
  get '/chapter7_1', to: 'chapters#chapter7_1'
  get '/chapter7_2', to: 'chapters#chapter7_2'
  get '/chapter7_3', to: 'chapters#chapter7_3'
  
  get '/chapter8_1', to: 'chapters#chapter8_1'
  get '/chapter8_2', to: 'chapters#chapter8_2'
  
  get '/chapter9_1', to: 'chapters#chapter9_1'
  get '/chapter9_2', to: 'chapters#chapter9_2'
  
end
