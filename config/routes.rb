Rails.application.routes.draw do
  #get '/', to: 'tasks#index' do
  resources :tasks
  #end
end
