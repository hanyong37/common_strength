Rails.application.routes.draw do
  #admin user resources
  #get 'admin/sessions/current_user', to: 'admin/sessions#show'
  namespace :admin do
    resources :sessions, only: [:create, :destroy]
    resources :settings, only: [:index, :update, :show]
    resources :course_types, only: [:index, :create, :update, :destroy]
    resources :courses, only: [:index, :create, :update, :destroy, :show]
    resources :schedules, only: [:show, :index, :create, :update, :destroy]
    resources :trainings, only:[:index, :create, :update, :show, :destroy]
    resources :operations,only: [:index, :show]

    resources :customers do
        resources :operations,only: [:index, :show]
        resources :trainings, only:[:index, :show]
    end

    resources :users do
      resources :operations, only:[:index]
    end

    resources :stores, only: [:show, :index, :create, :update, :destroy] do
      resources :schedules, only: [:index]

      resources :schedules_by_week, only: [:show, :create, :destroy] do
        resources :trainings, only: [:index]
        resources :publish_all, only: [:create]
        resources :unpublish_all, only: [:create]
      end

      resources :courses, only: [:index, :create, :update, :destroy, :show] do
        resources :schedules, only: [:show, :index, :create, :update, :destroy] do
          resources :trainings, only:[:index, :create, :update, :show, :destroy]
        end
      end

      resources :customers do
        resources :operations,only: [:destroy, :index, :show]
        resources :trainings, only:[:index, :create, :update, :show, :destroy]
      end
    end
  end

  # 微信端接口
  namespace :weixin do
    resources :sessions, only: [:create, :destory]
    resources :schedules, only: [:index, :destory]
    resources :trainings, only: [:index, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

