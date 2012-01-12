class VideosController < ApplicationController
  def index
    if params[:search]
      @videos = Video.search(params[:search],params[:all])
      @message = "#{@videos.count} results matching your query '#{params[:search]}'"
      if params[:all]=="1"
        @message = @message +
          " including videos not yet available. '#{params[:all]}' #{params[:all].class}"
      end
    else
      @videos = Video.available.find(:all, :order => 'recorded_at desc', :limit => 10)
      @message = "The ten most recent videos available."
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

    if (@video.available? && @video.event.ready?) || (session.user && session.user.admin?)
      @videos = Video.available.find(:all,
                         :conditions => ['event_id = ?',
                                         @video.event_id],
                         :order => 'recorded_at')
    else
      flash[:error]="The video '#{@video.title}' is not currently available."
      redirect_to event_path(@video.event)
    end
  end
end
