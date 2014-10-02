Rails.application.routes.draw do
  root 'home#index'
  get 'location', to: 'home#location'
end
