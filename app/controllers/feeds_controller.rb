class FeedsController < ApplicationController
  layout false

  def index
    @videos = Video.available.find(:all, :order => 'post_date desc, recorded_at desc')
    @title = "Confreaks, LLC - All Videos Feed"
    @updated = @videos.first.updated_at unless @videos.empty?
  end
end
