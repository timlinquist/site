require 'rubygems'
require 'isolate'

Isolate.gems "vendor/isolated" do
  gem "haml",          "~>3.0"
  gem "will_paginate", "~>2.3", :source => 'http://gemcutter.org'
  gem "rails",         "=2.3.5"
end
