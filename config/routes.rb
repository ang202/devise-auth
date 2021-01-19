Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      devise_for :users, path: '/user', only: %i[registrations sessions]
      resources :courses, only: %i[index]
    end
  end
end
