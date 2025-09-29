Rails.application.routes.draw do
  devise_for :users


  namespace :admin do
    resources :users, only: [ :index, :edit, :update ]
   end

  root "consults#mine"

  resources :consults do
    collection do
      get :mine      # Consults asked by current user
      get :assigned  # Consults assigned to current user
    end
    resources :answers, only: [ :create ]
  end
end
