Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # resource :session
  # resources :passwords, param: :token
  # Health check route remains
  get "up" => "rails/health#show", as: :rails_health_check

  # Define the root route to the home action in PagesController
  root "pages#home"

  # Define a route for the dashboard action
  get "dashboard", to: "pages#dashboard"

  # You can add more custom routes here as needed
end
