Rails.application.routes.draw do
  get 'music/index', as: :music

  resources :songs
  devise_for :users

  resources :users do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  root to: 'music#index'
end
