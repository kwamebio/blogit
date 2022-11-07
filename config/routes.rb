Rails.application.routes.draw do
  get 'users/show'
  root "blogs#index"

  resources :blogs do 
    collection do 
      get "bin"
    end 
    resources :votes
  end

  resources :blogs do
    resources :votes do
    end
  end
  get 'votes/create'
  resources :blogs


  get 'blogs/index'
  get 'blogs/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resource :session 

  resources :blogs do
    resources :votes 
  end

  resources :users

  
end
