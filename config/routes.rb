Rails.application.routes.draw do
  get 'session/home'

  post 'session/create'

  get 'session/destroy'


  resources :employees
  resources :teams do
    resources :shifts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
