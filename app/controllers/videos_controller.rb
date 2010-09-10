require 'rdiscount'

class VideosController < ApplicationController
  def index
    if params[:search]
      @videos = Video.search(params[:search],params[:available_only])
      @message = "#{@videos.count} results matching your query '#{params[:search]}'"
    else
      @videos = Video.find(:all, :order => 'recorded_at desc', :limit => 5)
      @message = "The five most recent videos"
    end
    render :layout => 'admin'
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
