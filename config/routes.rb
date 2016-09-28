Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :topics do
    resources :comments
  end
  resources :contacts, only: [:new, :create] do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
  root 'top#index'
end
