Rails.application.routes.draw do
  root 'landing#home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # SIMPLE RESOURCES
  resources :credits, only: [:index]
  resources :debts,   only: [:index]

  # CUSTOM RESOURCES
  resources :payments, only: [] do
    post :deactivate, on: :member
  end

  resources :landing, only: [] do
    get :home, on: :collection
  end

  # NAMESPACE RESOURCES

  # COMPLEX RESOURCES
  resources :bills, except: [:destroy] do
    get  :get_split_users, on: :collection
    post :deactivate, on: :member
    resources :payments, only: [:index, :create], controller: :bill_payments
  end

  resources :users do
    resources :payments, only: [:index, :create], controller: :user_payments
  end

  #MISC RESOURCES/ROUTES
end
