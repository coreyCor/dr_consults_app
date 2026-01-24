Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users, only: [ :index, :edit, :update ] do
      collection do
        get :weekly_schedule
      end
    end
  end

  # root "consults#mine"
  root "consults#schedule"
  resources :consults do
    collection do
      get :mine      # Consults asked by current user
      get :assigned
      get :schedule
      # get :weekly_schedule # Consults assigned to current user
    end
    resources :answers, only: [ :create ]
  end
  resources :fbx_neo_consults, path: "fbx_neo", only: [ :new, :create, :index, :show ], path: "fbx_neo" do
  collection do
    get :mine
  end
end
end
