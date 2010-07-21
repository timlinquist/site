require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  model_template_for User do
    {
      :username  => "tester",
      :email     => "test@test.com",
      :password  => '123456',
      :time_zone => 'Pacific Time (US & Canada)'
    }
  end

  test_validations_for :username, :uniqueness
  test_validations_for :email, :uniqueness
  test_validations_for :username, :presence
  test_validations_for :time_zone, :presence

  def test_create
    u = User.new
    u.username = "GlourisTester"
    u.email = "test@test.com"
    u.password = "123456"
    u.time_zone = "Pacific Time (US & Canada)"

    assert u.save
    assert_not_equal nil, u.password_hash
    assert_not_equal nil, u.password_salt
  end

end
