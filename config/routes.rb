Rails.application.routes.draw do
  devise_for :users, skip: [ :registration ]

  namespace :admin do
    resources :users, only: [ :index, :new, :create, :edit, :update ] do
      collection do
        get :weekly_schedule
      end
    end
  end
    # remove below 3 after stim test
    get "/test_integration", to: "test#show"
    patch "/test_integration/update", to: "test#update"
    delete "/test_integration/delete", to: "test#destroy"
  # root "consults#mine"
  root "consults#taskscreen"
  resources :consults do
    collection do
      get :mine      # Consults asked by current user
      get :assigned
      get :schedule
      get :taskscreen
      # get :weekly_schedule # Consults assigned to current user
    end
    resources :answers, only: [ :create ]
  end
  resources :fbx_neo_consults, only: [ :new, :create, :index, :show ], path: "fbx_neo" do
  collection do
    get :mine
  end
end


resources :users, only: [] do
  member do
    get :availability
    get :availability_row  # new route for table row
  end
 end
end
