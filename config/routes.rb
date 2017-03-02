Rails.application.routes.draw do

  get 'landing/home'

  root 'landing#home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bills
  resources :payments

  resources :bills do
    resources :payments, only: [:index], controller: :bill_payments do
      post :pay, on: :collection
    end
  end
end
