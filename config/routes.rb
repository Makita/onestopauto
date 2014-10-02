Rails.application.routes.draw do
  root 'home#index'
  get 'location', to: 'home#location'
  get 'about', to: 'home#about'
end
