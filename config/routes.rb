Rails.application.routes.draw do
  root 'search#index'
  
  get 'search/index'

  post 'search/processor'
  
  get 'search/processor'

  get 'search/results'
  
  get 'search/next'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
