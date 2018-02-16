Rails.application.routes.draw do

  get '/logout', to: 'session#destroy', as: 'logout'
  get '/dashboard', to: 'employees#dashboard', as: 'dashboard'
  get '/swap', to: 'employees#swap', as: 'swap'
  post '/shift_by_date', to: 'shifts#show_by_date', as: 'show_by_date'

  resources :employees
  resources :teams do
    resources :shifts
  end
  resources :session, only: [:home, :create, :destroy]

  root 'session#home'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
