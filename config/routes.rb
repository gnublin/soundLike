
Rails.application.routes.draw do

  get '/login', to:  'sessions#login'
  get '/logout', to:  'sessions#log_out'
  get '/install', to: 'install#install'
  get '/save', to: 'install#save'
  get '/music', to: 'soundlike#music'
  get '/napi/:id', to: 'napi#show'
  get '/api/:id', to: 'api#userManage'
  get '/api', to: 'api#display'
  get '/redisGet', to: 'napi#redisGet'
  get '/media', to: 'media#show'
  post '/new', to: 'sessions#new'
  root 'sessions#new'
  get   '*unmatched_route', to: 'soundlike#not_found'

end
