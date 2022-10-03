Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope defaults: { format: :json } do
    root to: 'tasks#index'
    resources :users, only: [:create, :update]
    resources :sessions, only: [:create]
    resources :tasks, only: [:index, :create, :destroy, :edit, :show, :update, :new]
    resources :categories, only: [:index, :create, :destroy, :edit, :show, :update, :new]
    controller :passwords do
      post 'passwords' => :create
      patch 'passwords' => :update
    end
  end
  
end
