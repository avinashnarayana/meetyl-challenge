Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :meetings do
    resources :invitations
  end
  resources :invitations
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end
