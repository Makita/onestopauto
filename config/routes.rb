Rails.application.routes.draw do
  root 'home#index'
  get 'location', to: 'home#location'
  get 'about', to: 'home#about'

  scope 'appointment' do
    get ':type', to: 'appointment#new', as: 'new_appointment'
  end
end
