Rails.application.routes.draw do
  post "social/follow"
  post "social/unfollow"

  namespace :sleep_records do
    get "feed/my_records"
    get "feed/following_records"

    post "operation/sleep"
    post "operation/wake_up"
    post "operation/reset"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
