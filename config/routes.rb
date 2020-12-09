Rails.application.routes.draw do
  root 'sessions#new'
  resources :tasks
  resources :sessions

  namespace :admin do
    resources :users
  end
end
