Rails.application.routes.draw do
  namespace :admin do
    resources :posts
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'homepage#show'

  resources :posts
  resources :tags
  resources :places

  namespace :admin do
    resources :posts, :except => [:edit]
    resources :tags, :except => [:edit]
    resources :places, :except => [:edit]
    root 'posts#index'
  end
end
