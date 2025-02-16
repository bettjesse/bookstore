Rails.application.routes.draw do
  resources :books, only: [:index, :show]
  
  # Standalone route for borrowing a book
  post '/books/:id/borrow', to: 'borrowings#create', as: 'borrow_a_book'
  
  resources :borrowings, only: [] do
    member do
      patch 'return', to: 'borrowings#return', as: 'return_borrowing'
    end
  end

  resource :session
  resources :passwords, param: :token
  resources :users, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
  get "dashboard", to: "pages#dashboard"
end
