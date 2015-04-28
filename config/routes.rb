Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'homepage#show'

  namespace :admin do
    resources :posts, :except => [:edit]
    #resources :tags, :except => [:edit]
    resources :places, :except => [:edit]
    root 'posts#index'
  end

  get 'm/:place' => 'posts#index'
  get 't/:tag' => 'posts#index'
  get 'm/:place/:id' => 'posts#show'
  get 't/:tag/:id' => 'posts#show'
  get 'latest' => 'posts#index'
  get ':id' => 'posts#show', :as => :post
end
