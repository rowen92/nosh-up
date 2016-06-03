Rails.application.routes.draw do

  post 'line_items/increase_quantity' => 'line_items#increase_quantity'
  post 'line_items/decrease_quantity' => 'line_items#decrease_quantity'
  resources :line_items, only: [:create, :destroy]
  resources :categories, :users, :sessions, :orders
  get 'search_suggestions' => 'products#search_suggestions', as: :search_suggestions

  resources :products do
    resources :comments
  end

  get 'cart' => 'carts#show'
  delete 'cart.:id' => 'carts#destroy'

  namespace :admin do
    resources :categories, :users, :products, :spoiled_foods
    resources :recipes do
      patch 'edit_weight' => 'recipes#edit_weight'
    end
    resources :foods do
      get 'cancel' => 'foods#cancel'
    end
    resources :orders do
      collection do
        get 'download_check_pdf'
      end
    end
    resources :reports do
      collection do
        get 'download_success_orders_pdf'
        get 'download_cancel_porducts_pdf'
      end
    end
  end

  get 'admin' => 'admin/admin#index'
  root 'pages#index'

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
  #     #   end
end
