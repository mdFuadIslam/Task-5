Rails.application.routes.draw do

  resources :home, only: [:region, :error,:seed]
  # Define routes here
  root to: 'home#index'

  get '/update_data', to: 'home#update_data'
  get '/generate_fake_data', to: 'home#generate_fake_data'

end
