require 'test_helper'

class RedirectsTest < ActionController::IntegrationTest
  fixtures :all

  def test_page_redirect_agileroots2009
    get '/redirects/agileroots2009/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick.html'

    assert_response :redirect
  end

  def test_file_redirect_small_agileroots2009
    get '/redirects/agileroots2009/videos/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick-small.mp4'

    assert_response :redirect
  end

  def test_file_redirect_large_agileroots2009
    get '/redirects/agileroots2009/videos/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick-large.mp4'

    assert_response :redirect
  end

  def test_domain_redirect_agileroots2009
    get '/redirects/agileroots2009/videos/'

    assert_response :redirect
  end

  def test_domain_redirect_mwrc2010
    get '/redirects/mwrc2010/videos/'

    assert_response :redirect
  end

  def test_page_redirect_mwrc2010
    get '/redirects/mwrc2010/videos/2010-03-12-13-30-sarah-allen-mobile-ruby.html'

    assert_response :redirect
  end

  def test_file_redirect_small_mwrc2010
    get '/redirects/agileroots2009/videos/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick-small.mp4'

    assert_response :redirect
  end

  def test_file_redirect_large_mwrc2010
    get '/redirects/mwrc2010/videos/videos/16-jun-2009-09-00-artisanal-retro-futurism-team-scale-anarcho-syndicalism-brian-marick-large.mp4'

    assert_response :redirect
  end


end
