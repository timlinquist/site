ActionController::Routing::Routes.draw do |map|

  map.dispcal '/calendar/:year/:month', 
    :controller => 'calendar', 
    :action => 'index', 
    :year => Time.zone.now.year, 
    :month => Time.zone.now.month

  map.root :controller => "main", :action => "home_page"
  map.terms_of_service '/terms-of-service', :controller => "main", 
                                            :action     => "tos"
  map.privacy_policy   '/privacy-policy',   :controller => "main", 
                                            :action     => "privacy"

  map.resource  :session, :member => { :reset => [:get, :post] }

  map.resources :events
  map.resources :videos do | video |
    video.resources :assets
  end

  map.resources :presenters
  map.resources :users
  map.resources :conferences

  map.admin "/admin", :controller => 'admin/root',  :action => 'index'

  map.namespace :admin do | admin |
    admin.resources :videos
    admin.resources :events do |event|
      event.resources :videos
    end
    admin.resources :presenters
    admin.resources :conferences
    admin.resources :users
    admin.resources :asset_types
    admin.resources :assets
  end
end
