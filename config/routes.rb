Rails.application.routes.draw do
  #get 'music/index', as: :music
  resources :music, only: [:index], controller: :music do
    member do
      patch :add_to_list
      patch :remove_from_list
    end
  end

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
