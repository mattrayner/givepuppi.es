Givepuppies::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  root :to => "welcome#index"

  get '/dashboard', :to => 'dashboard#index'

  get '/dashboard/users/', :to => 'users#index'
  get '/dashboard/users/new', :to => 'users#new'

  get '/dashboard/puppies', :to => 'puppy#index'
  get '/dashboard/puppies/new', :to => 'puppy#new'
  get '/dashboard/puppies/edit', :to => 'puppy#edit'

  post '/dashboard/puppies', :to => 'puppy#create', as: :puppies

  # Create an API namespace for our API and add versioning too!
  namespace :api, :defaults => {:format => :json} do #:constraints => {:subdomain => "api"}, :path => "" do #:path => ""
    namespace :v1 do
      resources :puppies
    end
  end
end
