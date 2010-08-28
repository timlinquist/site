require 'RDiscount'

class VideosController < ApplicationController
  def index
    @videos = Video.find(:all, :order => 'recorded_at desc')
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
    @video = Video.find(params[:id])
    @videos = Video.find(:all, :conditions => ['event_id = ?', @video.event_id],
                        :order => 'recorded_at')

  end
end
