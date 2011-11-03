# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Confreaks::Application.initialize!

## pre rails3 environment
#
# require 'confreaks'
# require 'disqus'
#
# Rails::Initializer.run do |config|
#   Confreaks.config[:google_analytics_key]="UA-9089544-7"
#   Confreaks.config[:zencoder_api_key]="79517d12641249bb20140e45eec23c7b"
#   config.time_zone = 'Pacific Time (US & Canada)'
#   config.action_mailer.raise_delivery_errors = false
#   config.action_mailer.default_url_options = { :host => 'localhost' }
#
#   config.action_controller.asset_host = "http://confreaks.net"
#
#   config.after_initialize do
#     Disqus::defaults[:account]="confreaks"
#     Disqus::defaults[:container_id]="disqus_thread"
#     Disqus::defaults[:developer] = true
#     Disqus::defaults[:show_powered_by] = false
#   end
# end
#
# require 'will_paginate'
# require 'rdiscount'
# require 'newrelic_rpm'
#
