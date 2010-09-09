require 'rdiscount'

class VideosController < ApplicationController
  def index
    @videos = Video.search(params[:search])
  end

  def new
    redirect_to videos_path
  end

  def create
    redirect_to videos_path
  end

  def update
    @video = Video.find(params[:id])

    redirect_to video_path(@video)
  end

  def destroy
    @video = Video.find(params[:id])
  end

  def show
    @p = Confreaks::ParseUserAgent.new

    @p.parse request.env["HTTP_USER_AGENT"]

    @player = params[:player] || "html5"

    @video = Video.find(params[:id])
    @videos = Video.find(:all, :conditions => ['event_id = ?', @video.event_id],
                        :order => 'recorded_at')

  end
end
