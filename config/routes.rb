MyStackOverflow::Application.routes.draw do
  devise_for :users

  resources :questions do
  	resources :answers, only: [:create, :edit, :update, :destroy]
    resources :votes, only: [:create]
	end

  resources :answers, only: [] do
    resources :votes, only: [:create]
  end

  resources :users, only: [:show, :edit, :update] do
    resource :role, only: [:update]
  end

  namespace :api do
    resources :questions, only: [:index, :show]
  end

  root to: 'questions#index'
end
