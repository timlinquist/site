ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require 'modelizer'

Intercession.test!

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  fixtures :all

  def refute expr, message = nil
    assert !expr, message
  end

  alias :refute_equal :assert_not_equal

  def login user, password = "123456", &block
    user = users(user) if Symbol === user
    @request.session[:user_id] = user.id

    if block_given?
      yield user
      @controller.session[:user_id] = nil
    end

    user
  end

  def logout
    @request.session[:user_id] = nil
  end
end

class Test::Unit::TestCase
  include Modelizer
end
