Rails.application.routes.draw do

  resources :articles

  scope :users do
    post 'signup', to: 'users#signup'
    post 'login', to: 'users#login'
    get 'profile', to: 'users#profile'
  end
end
