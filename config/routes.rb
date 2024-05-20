require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount API::Base => '/api'

  namespace :admin do
    resources :posts, only: [:index]
  end
end
