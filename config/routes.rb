Rails.application.routes.draw do
  get 'users/new'
  root to: 'static_pages#root'
  get '/pricing', to: 'static_pages#pricing'

  resource :user
end
