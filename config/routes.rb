Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :projects do
    resources :bugs
    resources :features
  end

  resources :assigns
  # root "projects#index"

  post 'projects/:id', to: 'projects#show', as: :p
  # delete 'projects/:id', to: 'projects#destroy'

  devise_scope :user do
    # get 'sign_in', to: 'devise/sessions#new'
    root 'devise/sessions#new'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
