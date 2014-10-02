Rails.application.routes.draw do
  root 'home#index'
  get 'location', to: 'home#location'
  get 'about', to: 'home#about'

  resources :appointments, only: [:create, :show]
  get 'appointments/new/:type', to: 'appointments#new', as: 'new_appointments'
end
