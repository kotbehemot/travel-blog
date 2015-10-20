Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  get '/:locale' => 'homepage#show', constraints: {locale: /en/}
  get 'map_locations.json' => 'homepage#map_locations', :format => :json

  scope "(:locale)", locale: /en|pl/, constraints: {locale: /en|pl/} do
    namespace :admin do
      resources :posts, :except => [:edit]
      #resources :tags, :except => [:edit]
      resources :places, :except => [:edit]
      resources :locations, :except => [:edit]
      resources :homepage_photos, :except => [:edit]
      resources :homepage_settings, :except => [:edit]
      root 'posts#index'
    end
  end

  scope "(:locale)", locale: /en/, constraints: {locale: /en/} do
    get 'm/:place' => 'posts#index', :as => :placed_posts
    get 't/:tag' => 'posts#index', :as => :tagged_posts
    get 'm/:place/:id' => 'posts#show', :as => :placed_post
    get 't/:tag/:id' => 'posts#show', :as => :tagged_post
    get 'latest' => 'posts#index', :as => :latest_posts
    get ':id' => 'posts#show', :as => :post
  end
  root 'homepage#show'

end
