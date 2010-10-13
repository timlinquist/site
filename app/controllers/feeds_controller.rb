class FeedsController < ApplicationController
  layout false

  def index
    @videos = Video.available.find(:all, :order => 'post_date desc, recorded_at desc')
    @title = "Confreaks, LLC - All Videos Feed"
    @updated = @videos.first.updated_at unless @videos.empty?
  end

  def show
    @event = Event.find_by_identifier(params[:id])
    @videos = @event.videos(:order => 'post_date desc, recorded_at desc')

    @title = @event.display_name
    @updated = @videos.first.updated_at unless @videos.empty?

    render 'index'
  end
end
