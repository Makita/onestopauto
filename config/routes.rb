Rails.application.routes.draw do
  root 'home#index'
  get 'location', to: 'home#location'
  get 'about', to: 'home#about'

  resources :appointments, only: [:create, :show]
  get 'appointments/new/:type', to: 'appointments#new', as: 'new_appointments'
  post 'appointment/confirm', to: 'appointments#confirm', as: 'confirm_appointment'
  get 'check_appointment_hours', to: 'appointments#check_appointment_hours', as: 'check_appointment_hours'
  get 'check_appointment_minutes', to: 'appointments#check_appointment_minutes', as: 'check_appointment_minutes'

  scope '/admin' do
    get '', to: 'admin#index', as: 'admin'
    get 'sign_in', to: 'admin#sign_in', as: 'sign_in'
    post 'authenticate', to: 'admin#authenticate', as: 'authenticate'
    get 'sign_out', to: 'admin#sign_out', as: 'sign_out'

    get 'appointments', to: 'admin#appointments', as: 'admin_appointments'
  end

  namespace :admin do
    resources :posts, except: [:show]
  end
end
