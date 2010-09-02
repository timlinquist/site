RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

require 'confreaks'

Rails::Initializer.run do |config|
  Confreaks.config[:google_analytics_key]="UA-9089544-7"
  config.time_zone = 'Pacific Time (US & Canada)'
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'localhost' }

  config.gem "disqus"

  config.after_initialize do
    Disqus::defaults[:account]="confreaks"
    Disqus::defaults[:container_id]="disqus_thread"
    Disqus::defaults[:developer] = true
    Disqus::defaults[:show_powered_by] = false
  end
end

require 'will_paginate'
