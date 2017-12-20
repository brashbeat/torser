Rails.application.routes.draw do
  
  root 'application#index'
  
  get '/me', to: 'application#me'  

  post '/feedform', to: 'application#feedform'
  
  get 'search/results'

  post 'search/results'

end
