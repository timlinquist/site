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
    @v
  end

  def show
    @video = Video.find(params[:id])
  end
end
