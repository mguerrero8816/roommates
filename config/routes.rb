Rails.application.routes.draw do

  get 'landing/home'

  root 'landing#home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bills do
    post :pay, on: :member
  end
end
