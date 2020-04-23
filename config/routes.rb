Rails.application.routes.draw do
  root to: 'static_pages#root'
  get '/pricing', to: 'static_pages#pricing'
end
