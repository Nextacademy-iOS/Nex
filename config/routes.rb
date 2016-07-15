Rails.application.routes.draw do
  resources :blogs
  root "blogs#index"

  namespace :api do
    namespace :v1 do
      resources :blogs, shallow: true do
        resources :comments
      end
    end
  end
end
