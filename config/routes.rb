Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resource :profile, only: [:show, :edit, :update], controller: "users/profiles"

  resources :courses, only: [:index, :show] do
    member do
      post :enroll
    end
    resources :reviews, only: [:create, :update, :destroy]
    resources :discussion_threads, only: [:index, :show, :new, :create] do
      resources :discussion_replies, only: [:create], path: "replies"
    end
    resources :lessons, only: [:show] do
      member do
        patch :complete
      end
    end
  end

  resources :certificates, only: [:index, :show]

  get "dashboard", to: "dashboard#index"

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :courses, only: [:index, :show]
    resources :users, only: [:index, :show, :edit, :update]
    resources :categories
  end

  namespace :instructor do
    get "dashboard", to: "dashboard#index"
    resources :courses do
      resources :lessons do
        member do
          patch :move_up
          patch :move_down
        end
      end
    end
  end
end
