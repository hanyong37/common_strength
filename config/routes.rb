Rails.application.routes.draw do
  #admin user resources
  #get 'admin/sessions/current_user', to: 'admin/sessions#show'
  namespace :admin do
    resources :sessions, only: [:create, :destroy]
    resources :users
    resources :settings, only: [:index, :update, :show]
    resources :customers
    resources :stores, only: [:show, :index, :create, :update, :destroy]
    resources :course_types, only: [:index, :create, :update, :destroy]
    resources :courses, only: [:index, :create, :update, :destroy, :show]
    resources :schedules, only: [:show, :index, :create, :update, :destroy]
    resources :trainings
    resources :operations,only: [:destroy, :index, :show]
  end

  namespace :weixin do
    resources :sessions, only: [:create, :destory]
    resources :schedules, only: [:index, :destory]
    resources :trainings, only: [:index, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

