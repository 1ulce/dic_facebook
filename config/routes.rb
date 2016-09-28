Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
end
