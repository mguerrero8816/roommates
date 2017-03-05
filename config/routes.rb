Rails.application.routes.draw do
  root 'landing#home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # SIMPLE RESOURCES

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
    post :deactivate, on: :member
    resources :payments, only: [:index], controller: :bill_payments do
      post :pay, on: :collection
    end
  end

  #MISC RESOURCES/ROUTES
end
