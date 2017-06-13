Rails.application.routes.draw do
  root 'landing#home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # SIMPLE RESOURCES
  resources :credits, only: [:index]
  resources :debts,   only: [:index]
  resources :admin,   only: [:index]

  # CUSTOM RESOURCES
  resources :apartments do
    get  :tenants,        on: :member
    get  :search,         on: :collection
    post :join_multiple,  on: :collection
    post :leave_multiple, on: :collection
  end

  resources :landing, only: [] do
    get :home, on: :collection
  end

  resources :payments, only: [] do
    post :deactivate, on: :member
  end

  resources :users, only: [] do
    get :current, on: :collection
  end



  # NAMESPACE RESOURCES
  namespace :admin do
    resources :users, except: [:index, :show]
    resources :roles, except: [:index, :show]
  end

  # COMPLEX RESOURCES
  resources :bills, except: [:destroy] do
    post :deactivate, on: :member
    resources :payments, only: [:index, :create], controller: :bill_payments
  end

  resources :users do
    resources :payments, only: [:index, :create], controller: :user_payments
  end

  #MISC RESOURCES/ROUTES
end
