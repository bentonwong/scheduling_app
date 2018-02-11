Rails.application.routes.draw do
  get 'session/home'

  get 'session/create'

  get 'session/destroy'

  resources :shifts
  resources :employees
  resources :teams
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
