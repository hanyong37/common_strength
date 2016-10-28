Rails.application.routes.draw do
  #admin user resources
  namespace :admin do
    resource :session, only: [:create, :destroy]
    resources :settings, only: [:index, :update, :show]
    resources :course_types, only: [:index, :create, :update, :destroy, :show]
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
    resource :session, only: [:create]
    resource :register, only: [:create]
    resources :my_schedules, only: [:show, :index] do
    end

    resources :my_trainings, only: [:index, :show, :create] do
      resource :booking, only: [:create]
      resource :cancel
    end
    resources :schedules, only: [:index, :d]
    resources :trainings, only: [:index, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

