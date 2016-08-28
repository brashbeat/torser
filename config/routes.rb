Rails.application.routes.draw do
  root 'search#index'
  
  get 'search/index'

  post 'search/processor'
  
  get 'search/processor',  to: 'search#index'

  get 'results/:pid',  to: 'search#results', as: 'page'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
