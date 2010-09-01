class Admin::VideosController < Admin::Controller
  layout "admin"

  def index
    @videos = Video.paginate(:all, 
                             :order => "recorded_at desc",
                             :page => params[:page])
  end

  def edit
    @events = Event.find(:all,
                         :order => "start_at desc")

    @video = Video.find(params[:id])
    @presenters = Presenter.find(:all, :order => 'last_name, first_name')
    if @video.assets.count == 0
      @video.assets.build
    end
    @asset_types = AssetType.find(:all, :order => 'description')
  end

  def new
    # TODO: Sort by Conference.name then Year desc
    @events = Event.find(:all,
                         :order => "start_at desc")
    @video = Video.new
    @video.presentations.build
    @video.assets.build
    @presenters = Presenter.find(:all, :order => 'last_name, first_name')
    @asset_types = AssetType.find(:all, :order => 'description')

    @event = Event.find_by_identifier(params[:event_id])

  end

  def create
    @video = Video.create(params[:video])

    if @video.save then
      flash[:success] = "The video was created successfully."

      redirect_to event_path @video.event
    else
      flash[:error] = "An error occured while creating the video: " +
        @video.errors.full_messages.to_sentence
      redirect_to new_admin_video_path
    end
  end

  def update
    @video = Video.find(params[:id])

    @video.attributes = params[:video]

    if @video.save
      flash[:success]="The video was saved successfully."
    else
      flash[:error]="The video changes could not be saved: " +
        @video.errors.full_messages.to_sentence
    end

    redirect_to event_path @video.event
  end

  def destroy
    @video = Video.find(params[:id])

    event = @video.event

    if @video.destroy
      flash[:success]="The video was successfully deleted."
    else
      flash[:error]="The video could not be deleted: " +
        @video.errors.full_messages.to_sentence
    end
    redirect_to admin_event_path event
  end
end
