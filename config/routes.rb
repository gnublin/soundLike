Rails.application.routes.draw do

  get '/login', to:  'sessions#login'
  get '/install', to: 'install#install'
  get '/save', to: 'install#save'
  root 'sessions#new'
  get   '*unmatched_route', to: 'soundlike#not_found'

end
