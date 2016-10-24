Rails.application.routes.draw do
  #admin user resources
  #get 'admin/sessions/current_user', to: 'admin/sessions#show'
  namespace :admin do
    resources :sessions, only: [:create, :destroy]
    resources :settings, only: [:index, :update, :show]
    resources :users
    resources :course_types, only: [:index, :create, :update, :destroy]

    resources :stores, only: [:show, :index, :create, :update, :destroy] do
      resources :schedules_by_week, only: [:show, :create, :destroy]
      resources :schedules, only: [:show, :index, :create, :update, :destroy]
      resources :courses, only: [:index, :create, :update, :destroy, :show] do
        resources :schedules, only: [:show, :index, :create, :update, :destroy] do
          resources :week, only: [:index, :create, :destroy]
          resources :trainings, only:[:index, :create, :update, :show, :destroy]
        end
      end
      resources :customers do
        resources :operations,only: [:destroy, :index, :show]
        resources :trainings, only:[:index, :create, :update, :show, :destroy]
      end
    end
## ----not good below:----
    resources :customers
    resources :courses, only: [:index, :create, :update, :destroy, :show]
    resources :schedules, only: [:show, :index, :create, :update, :destroy]
    resources :trainings, only:[:index, :create, :update, :show, :destroy]
    resources :operations,only: [:destroy, :index, :show]
  end

  namespace :weixin do
    resources :sessions, only: [:create, :destory]
    resources :schedules, only: [:index, :destory]
    resources :trainings, only: [:index, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

