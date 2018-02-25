Rails.application.routes.draw do

  get '/logout', to: 'session#destroy', as: 'logout'
  get '/dashboard', to: 'employees#dashboard', as: 'dashboard'
  get '/dashboard/:team_id/shifts/:id', to: 'employees#shift_details', as: 'shift_details'
  get '/create_admin', to: 'employees#create_admin', as: 'create_admin'

  resources :employees
  resources :teams do
    resources :shifts
  end
  resources :session, only: [:home, :create, :destroy]
  resources :requests, only: [:create, :update]
  resources :responses, only: [:update]

  root 'session#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
