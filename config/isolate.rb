gem "rake", "0.8.7"
gem "rails",         "= 2.3.14"
gem "uuid",          "= 2.3.1"
gem "will_paginate", "= 2.3.14"
gem "haml",          "= 3.0.6"
gem "paperclip",     "= 2.3.1.1"
gem "rvideo"
gem "rdiscount"
gem "disqus"
gem "twitter_oauth"
gem "rest-client"
gem "zencoder"
gem "newrelic_rpm"
gem "ruby-mysql", "=2.9.3", :lib => 'mysql'

env :development, :test do
  gem "modelizer"
  gem "sqlite3"
  gem "rdoc"
end

