DBFruitVar::Application.routes.draw do
  
  post "select_collection/select"
  get "report_menu/index", as: :report_menu
  get "blocks/select", as: :blocks_select
  #get "production_records/report", as: :production_records_report

  resources :blocks do
    resources :phenology_records
    resources :production_records
    member do
      get 'showphenology'
    end
  end 

  resources :phenology_records
  
  resources :production_records do
    collection do
      get 'report'
    end
  end

  
  resources :trees

  resources :accessions do
    collection do
      get 'report'
      get 'summary_report'
    end
  end

  resources :collections do
   collection do
      get 'report'
      get 'map'
    end
  end

  resources :groups

  resources :species

  resources :countries

  resources :locations


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
