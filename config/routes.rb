Rails.application.routes.draw do
  # Define routes here
  root to: 'home#index'

  post '/update_data', to: 'home#update_data'
  get '/generate_fake_data', to: 'home#generate_fake_data'
end
