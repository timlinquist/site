class FeedsController < ApplicationController
  layout false
  
  def index
    @videos = Video.find(:all, :order => 'recorded_at desc')
    @title = "Confreaks, LLC - All Videos Feed"
    @updated = @videos.first.created_at unless @videos.empty?
  end
end
