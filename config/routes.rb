Rails.application.routes.draw do
  root 'search#index'
  
  get 'search/index'

  post 'search/processor'
  
  get 'search/processor',  to: 'search#index'
  
  get 'results/all/:pid', to: 'search#all', as: 'pageALL'

  get 'results/tpb/:pid',  to: 'search#resultsTPB', as: 'pageTPB'
  
  get 'results/yts/:pid', to: 'search#resultsYTS', as: 'pageYTS'
  
  get 'results/extor/:pid', to: 'search#resultsXTOR', as: 'pageXTOR'
  
  get 'search/ytsall'
  
  get 'search/tpball'
  
  get 'search/xtorall'
  
  get '/me', to: 'search#me'
  
  post 'search/feedform'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
