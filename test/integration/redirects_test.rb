require 'test_helper'

class RedirectsTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  def test_page_redirect
    get '/redirects/agileroots2009/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick.html'

    assert_response :redirect
  end

  def test_file_redirect_small
    get '/redirects/agileroots2009/videos/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick-small.mp4'

    assert_response :redirect
  end

  def test_file_redirect_large
    get '/redirects/agileroots2009/videos/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick-large.mp4'

    assert_response :redirect
  end

  def test_domain_redirect
    get '/redirects/agileroots2009/videos/'

    assert_response :redirect
  end

end
