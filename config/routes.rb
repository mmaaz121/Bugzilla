Rails.application.routes.draw do
  devise_for :users

  resources :projects
  # root "projects#index"

  devise_scope :user do
    # get 'sign_in', to: 'devise/sessions#new'
    root 'devise/sessions#new'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
