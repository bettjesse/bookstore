Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    member do
      post :borrow, to: 'borrowings#create'
    end
  end

  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
  get "dashboard", to: "pages#dashboard"
end
