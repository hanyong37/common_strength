Rails.application.routes.draw do
  resources :customers
  resources :stores
  resources :course_types
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :settings
  resources :courses
  resources :trainings
  resources :users
end

