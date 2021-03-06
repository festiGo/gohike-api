require 'api'
Gohike::Application.routes.draw do

  resources :organizations


  root :to => "home#index"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    get "state_province_list", :to => "cities#states_or_provinces"

    get '/translation/:resource_type/:resource_id(/:target_locale)', :to => "translations#new", :as => :translation

    get "start", :to => "start#index"

    get "admin/index"

    get "home", :to => "home#index"

    resources :routes do
      resource :reward
      member do
        put :waypoints
        get :crop
        put :publish
        put :unpublish
      end
    end
    resources :rewards
    resources :checkins

    resources :cities do
      resources :route_profiles
      resources :locations do
        collection do
          get :search
        end
      end
    end

    resources :route_profiles do
      collection do
        get :in_cities
      end
      member do
        get :crop
      end
    end

    resources :locations do
      member do
        get :crop
      end

    end
    resources :devices
    devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}
    match 'users/profile' => 'users#profile'
    scope "/admin" do
      resources :users do
        member do
          put :assign_to_organization
          # match "assign_to_organization/:organization_id" => "users#assign_to_organization"
        end
      end
    end


  end
  mount Gohike::API => "/api"
  #match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  #match '', to: redirect("/#{I18n.default_locale}")


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
