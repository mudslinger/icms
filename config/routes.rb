Icms::Application.routes.draw do

  GETPOST = [:get,:post].freeze

  scope "/my" do

    match 'login'              => "guser_sessions#login" ,as: :mypage_login,via: GETPOST
    match 'logout'             => 'guser_sessions#destroy', as: :mypage_logout,via: GETPOST
    match 'signup'             => "guser_sessions#signup" , as: :mypage_signup,via: GETPOST
    match 'fb_callback_signup' => "guser_sessions#fb_callback_signup" , as: :fb_callback_signup,via: GETPOST
    match 'fb_callback_login'  => "guser_sessions#fb_callback_login" ,  as: :fb_callback_login,via: GETPOST
    resources :favorites do
     get 'add' , :on => :collection
    end
    resources :my_entries
  end

  #↓未定
  #resources :replies

  scope "/manager" do
    resources :action_logs

    resources :app_configs

    resources :user_profiles do
      get 'fb_callback_assoc', :on => :collection
      get 'fb_assoc_cancel', :on => :collection
    end

    resources :users

    resources :libraries

    resources :forms do
      get 'download'
    end

    resources :fields

    resources :entry_metas


    resource :user_session do
      get 'fb_callback'
    end

    match 'entries/import' => 'entries#import_post', as: :entries_import, via: GETPOST

    resources :entries

    get 'triggers/sweep_cache' => 'welcome#sweep_cache_trigger', as: :admin_triggers_sweep_cache

    match 'logout' => 'user_sessions#destroy', as: :logout,via: GETPOST

    match 'menu' => 'entries#index', as: :admin_menu,via: GETPOST
    match 'forward' => 'user_sessions#forward',via: GETPOST
    match 'sweep_cache' => 'welcome#sweep_cache', as: :admin_sweep_cache,via: GETPOST
    match 'app_reload' => 'welcome#reload', as: :admin_app_reload,via: GETPOST
    match 'geocode_picker' => 'welcome#geocode_picker', as: :admin_geocode_picker,via: GETPOST
    #プレビュー
    match 'contents/:name/:id' => 'contents#show_preview',  as: :contents_detail_preview,via: GETPOST
    match 'extra' => "app_configs#extra" , as: :admin_extra_menu,via: GETPOST
    match '/' => 'user_sessions#new',via: GETPOST
  end

  #/admin -> /manager に変更したことに対する互換性維持のため
  match 'admin/' => 'welcome#manage_legacy',via: GETPOST
  match 'admin/*path' => 'welcome#manage_legacy',via: GETPOST


  scope "/api" do
    resources :cms_users
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', as: :purchase
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
  get 'index' => "contents#top"
  root :to => "contents#top"

  # See how all your routes lay out with "rake routes"




  #match 'destroy/:id' => 'contents#destroy_cache'


  scope "/javascripts/tiny_mce/plugins/advimage/" do
    match 'image.htm'  => 'rfiles#new',   as: :rfile_upload,via:GETPOST
    get ':id.html'   => 'rfiles#show',  as: :rfile_show
    put ':id.update' => 'rfiles#update',as: :rfile
    delete ':id.update' => 'rfiles#destroy'
    get ':id.edit'   => 'rfiles#edit',  as: :edit_rfile

    resources :rfiles
  end

#  match 'contents/:name/index' => 'contents#index', as: :contents_index
#  match 'contents/:name/:id' => 'contents#view', as: :contents_detail

  #match ':name'     => 'contents#index', as: :contents_index
  #match ':name/:id' => 'contents#show',  as: :contents_detail
  #月別アーカイブ
  match 'contents/:name/archives/:date_field_name/:year-:month'     => 'contents#monthly_archives', as: :contents_monthly_archives,via: GETPOST
  #印刷
  match 'contents/:name/index-print'     => 'contents#index_print', as: :contents_page_print,via: GETPOST
  #match 'contents/:name/index-print-:page'     => 'contents#index_print', as: :contents_page_print_page
  #↓テスト

  match 'contents/:name/index-:page'     => 'contents#index', as: :contents_page,via: GETPOST
  match 'contents/:name/index'     => 'contents#index', as: :contents_index,via: GETPOST
  match 'contents/:name/:id' => 'contents#show',  as: :contents_detail,via: GETPOST
  #リダイレクト
  match 'contents/:name/' => 'contents#spelling',via: GETPOST

  match '*other'     => 'contents#static', as: :contents_static,via: GETPOST

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
