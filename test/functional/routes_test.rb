require 'test_helper'

class RoutesTest < ActionController::TestCase
  test 'root' do
    assert_routing '/', { :controller => 'main', :action => 'home_page' }
  end
  
  test 'terms-of-service' do
    assert_routing '/terms-of-service', { :controller => 'main', :action => 'tos' }
  end

  test 'privacy-policy' do
    assert_routing '/privacy-policy', { :controller => 'main', :action => 'privacy' }
  end

  test 'contact-us' do
    assert_routing '/contact-us', { :controller => 'main', :action => 'contact_us' }
  end

  test 'contact' do
    assert_routing '/contact', { :controller => 'main', :action => 'contact' }
  end

  test 'about-us' do
    assert_routing '/about-us', { :controller => 'main', :action => 'about_us' }
  end

  test 'services' do
    assert_routing '/services', { :controller => 'main', :action => 'services' }
  end

  test 'blog' do
    assert_routing '/blog', { :controller => 'blog', :action => 'index' }
  end

  test 'events/missing' do
    assert_routing '/events/missing', { :controller => 'events', :action => 'missing_event' }
  end

  test '/admin' do
    assert_routing '/admin', { :controller => 'admin/root', :action => 'index' }
  end
end
