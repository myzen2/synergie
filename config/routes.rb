Rails.application.routes.draw do
  get 'messages/new'

  get 'conversations/index'

  ActiveAdmin.routes(self)
  # You can have the root of your site routed with "root"
  root 'articles#accueil'
  get 'blog' => 'articles#blog'

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, at: '/forums'

  devise_for :users
  get 'users' => 'users#index'

  mount Ckeditor::Engine => '/ckeditor'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'dashboard' => 'dashboard#index'

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end
  end
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :restore
    end
  end
  resources :conversations, only: [:index, :show, :destroy] do
    collection do
      delete :empty_trash
    end
  end
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :mark_as_read
    end
  end
  resources :messages, only: [:new, :create]

  resources :users, only: [:index]

  namespace :dashboard do
    get 'profile'
    put 'update'
  end

  resources :articles do
    resources :comments
  end

  get 'qui' =>  'pages#qui'
  get 'reglement' => 'pages#reglement'

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
