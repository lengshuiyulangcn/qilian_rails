Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

   get '/mypage' => 'mypage#index'
   get '/mypage/courses' => 'mypage#my_courses', as: :my_courses
   resources :users
   get '/admin' => 'admin#index'
 # Show userinfo under admin
   get '/admin/userinfo/:id' => 'admin#userinfo', as: :admin_userinfo
   resources :entries, only: [:create,:destroy]
   scope :admin do
    resources :posts
    resources :jobs
    resources :labels
    resources :events
    resources :categories 
    resources :courses
   end
   get '/course/:id' => 'courses#detail', as: :course_detail
   get '/job/:id' => 'jobs#detail', as: :job_detail
   get '/jobs/search' => 'jobs#search', as: :job_search
   get '/jobs/label/:id' => 'jobs#single_search', as: :job_single_search
   get '/courses/all' => 'courses#all', as: :courses_all
   resources :news, only: [:index, :show]
   get '/news/category/:id' => 'news#category', as: :news_category
   scope :api do
     resources :schedules
   end
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
