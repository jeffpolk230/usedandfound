UF::Application.routes.draw do
  
  devise_for :users
  #get "welcome/index"
  # get "market" => "market#index", :as => 'market'
#   get "market/search" => "market#search" , :as => 'market_search'
  resources :goods, :except => [ :destroy , :index ] do
    resources :comments, :except => [ :index , :show ]
  end
  
  scope :path => '/goods' , :controller => 'goods' do
    get '/close/:id' => :close , :as => 'close_good'
    get '/warn/:id'  => :warn  , :as => 'warn_good'
  end
  
  #resources :categories, :except => [ :destroy , :index ]
  
  scope :path => '/market', :controller => 'market' do
    get '/(page/:page)' => :index, :constraint => { :page => /\d+/ } ,                :as => 'market'
    get '/search(/page/:page)' => :search, :constraint => { :page => /\d+/ } ,        :as => 'market_search'
    get '/category/:id(/page/:page)' => :category, :constraint => { :page => /\d+/ } , :as => 'market_category'
  end

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: 'welcome#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
