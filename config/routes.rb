ActionController::Routing::Routes.draw do |map|

  map.dispcal '/calendar/:year/:month',
    :controller => 'calendar',
    :action => 'index',
    :requirements => {:year => /\d{4}/, :month => /\d{1,2}/},
    :year => Time.zone.now.year,
    :month => Time.zone.now.month

  map.root :controller => "main", :action => "home_page"

  map.terms_of_service '/terms-of-service', :controller => "main",
                                            :action     => "tos"
  map.privacy_policy   '/privacy-policy',   :controller => "main",
                                            :action     => "privacy"
  map.contact_us       '/contact-us',       :controller => "main",
                                            :action     => "contact_us"
  map.contact          '/contact',          :controller => "main",
                                            :action     => "contact"
  map.about_us         '/about-us',         :controller => "main",
                                            :action     => "about_us"
  map.services         '/services',         :controller => "main",
                                            :action     => "services"
  map.blog '/blog', :controller => 'blog',  :action => 'index'

  map.resource  :session, :member => { :reset => [:get, :post] }

  map.missing_event    '/events/missing',   :controller => "events",
                                            :action     => "missing_event"

  map.resources :events, :member => { :missing_event => [:get] }

  map.resources :redirects do | redirect |
    redirect.resources :videos, :controller => 'redirects'
  end

  map.connect "/redirects/:redirect_id/videos/videos/:id.mp4", :controller => 'redirects', :action => 'file_redirect'

  map.resources :videos do | video |
    video.resources :assets
  end

  map.resources :feeds, :only => [:index, :show]

  map.resources :presenters
  map.resources :users
  map.resources :conferences

  map.admin "/admin", :controller => 'admin/root',  :action => 'index'

  map.namespace :admin do | admin |
    admin.attach    '/videos/attach/:id',
                         :controller => :videos,
                         :action => "attach"
    admin.encode    '/assets/encode/:id',
                         :controller => :assets,
                         :action => "encode"
    admin.refresh  '/assets/refresh/:id',
                         :controller => :assets,
                         :action => 'refresh_meta_data'

    admin.resources :videos
    admin.resources :events do |event|
      event.resources :videos do |video|
        video.resources :assets
      end
    end
    admin.resources :presenters
    admin.resources :conferences
    admin.resources :users
    admin.resources :asset_types
    admin.resources :assets
  end

  map.zc_callback '/zc-callback',
                  :controller => 'admin/videos',
                  :action => 'callback',
                  :method => ['post','get']
end
