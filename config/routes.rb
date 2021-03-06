Rails.application.routes.draw do
  get 'sessions/new'

  root 'public_pages#home'

  get 'contact' => 'public_pages#contact'
  get 'about' => 'public_pages#about'
	get 'random' => 'articles#random'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  resources :users, only: [:show, :new, :create, :destroy]
  resources :users, only: [], controller: "users/change_passwords" do
    member do
      get :change_passwords
      patch 'change_passwords' => 'users/change_passwords#update'
    end
  end


  resources :users, only: [] do
		get 'drafts' => 'users#drafts'
		resources :articles, only: [ :new ]
	end

  resources :users, only: [], controller: "users/change_emails" do
    member do
      get :change_emails
      patch 'change_emails' => 'users/change_emails#update'
    end
  end
	resources :articles, only: [:show, :edit, :create, :update, :destroy]
	resources :articles, only: [], controller: "articles/upvote" do
		member do
			patch 'upvote' => 'articles/upvote#upvote'
		end
	end
	resources :articles, only: [], controller: "articles/downvote" do
		member do
			patch 'downvote' => 'articles/downvote#downvote'
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
