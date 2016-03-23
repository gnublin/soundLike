Rails.application.routes.draw do

  get '/login', to:  'sessions#login'
  get '/install', to: 'install#install'
  get '/save', to: 'install#save'
  get '/music', to: 'soundlike#music'
  post '/new', to: 'sessions#new'
  root 'sessions#new'
  get   '*unmatched_route', to: 'soundlike#not_found'

end
