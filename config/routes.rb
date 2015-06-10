Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get '/:locale' => 'homepage#show', constraints: {locale: /en/}

  namespace :admin do
    resources :posts, :except => [:edit]
    #resources :tags, :except => [:edit]
    resources :places, :except => [:edit]
    resources :homepage_photos, :except => [:edit]
    root 'posts#index'
  end

  scope "(:locale)", locale: /en/, constraints: {locale: /en/} do
    get 'm/:place' => 'posts#index'
    get 't/:tag' => 'posts#index'
    get 'm/:place/:id' => 'posts#show'
    get 't/:tag/:id' => 'posts#show'
    get 'latest' => 'posts#index', :as => :latest_posts
    get ':id' => 'posts#show', :as => :post
  end
  root 'homepage#show'


end
