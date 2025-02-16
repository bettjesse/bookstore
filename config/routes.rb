Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    member do
      post 'borrow', to: 'borrowings#create'
    end
  end

  # Standalone route for returning a borrowed book
  patch '/borrowings/:id/return', to: 'borrowings#return', as: 'return_borrowing'

  resource :session
  resources :passwords, param: :token
  resources :users, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
  get "dashboard", to: "pages#dashboard"
end
