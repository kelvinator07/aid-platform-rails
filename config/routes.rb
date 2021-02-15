Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # namespace :api do
  #   namespace :v1 do
  #     resources :facts
  #   end
  # end

  namespace :api do
    namespace :v1 do
      get 'messages/:request_id', to: "messages#message"
      get 'messagebyuser/:user_id', to: "messages#messagebyuser"

      resources :messages
      resources :facts
      # post 'messages/new'
      # post 'messages', to: "messages#create"
    end
  end
  namespace :api do
    namespace :v1 do
      get 'requests/user/:user_id', to: "requests#userrequests" 
      resources :requests
      # get 'requests/show'
      # get 'requests/new'
      # get '/requests', to: "requests#index"
      # post '/requests', to: "requests#create"
      # put '/requests', to: "requests#update"
    end
  end
  namespace :api do
    namespace :v1 do
      resources :users

      post "/signup", to: "users#signup"
      # resource :users, only: [:create]
      post "/login", to: "users#login"
      #get "/auto_login", to: "users#auto_login"
      
    end
  end

end
