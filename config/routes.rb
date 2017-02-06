Rails.application.routes.draw do

  resources :teams
  root 'static_pages#home'

  get 'static_pages/home'
  get 'overview' => 'static_pages#overview'
  get 'static_pages/about'

  get '/rank_participants/check_order'
  get '/rank_participants/undolist'
  #delete '/rank_participants/:id/really_delete' => 'rank_participants#really_delete'
  patch '/rank_participants/:id/undo_deletion' => 'rank_participants#undo_deletion'

  resources :rank_participants


  get '/ranks/auto' => 'ranks#auto'
  get '/ranks/update_nums' => 'ranks#update_nums'
  get '/waves/auto' => 'waves#auto'
  get '/waves/update_nums' => 'waves#update_nums'

  get '/ranks/undolist'
  #delete '/ranks/:id/really_delete' => 'ranks#really_delete'
  patch '/ranks/:id/undo_deletion' => 'ranks#undo_deletion'
  resources :ranks

  get '/waves/undolist'
  #delete '/waves/:id/really_delete' => 'waves#really_delete'
  patch '/waves/:id/undo_deletion' => 'waves#undo_deletion'
  resources :waves

  get '/participants/match_rank'
  get '/participants/undolist'
  get '/participants/unfinished'
  patch '/participants/update_wave_by_bib_number/:bib_number/:wave_number' => 'participants#update_wave_by_bib_number'
  get '/participants/by_wave/:wave_number' => 'participants#by_wave'
  #delete '/participants/:id/really_delete' => 'participants#really_delete'
  patch '/participants/:id/undo_deletion' => 'participants#undo_deletion'
  resources :participants do
    collection do
      get :search_bib
    end
  end


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
end
