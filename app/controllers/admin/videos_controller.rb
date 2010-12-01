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
    @rooms = Room.find(:all, :conditions => ['event_id = ?', @video.event.id])

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
    if @event then
      @rooms = Room.find(:all, :conditions => ["event_id = ?",@event.id])
    end

  end

  def create
    @video = Video.create(params[:video])

    if @video.save then
      flash[:success] = "The video was created successfully."
      if params[:commit] == "Save" && @video.errors.nil?
        redirect_to event_path(@video.event)
      else
        flash[:success] += "<br>Adding another..."
        @events = Event.find(:all,
                             :order => "start_at desc")
        @video = Video.new
        @video.presentations.build
        @video.assets.build
        @presenters = Presenter.find(:all, :order => 'last_name, first_name')
        @asset_types = AssetType.find(:all, :order => 'description')

        @event = Event.find_by_identifier(params[:event_id])

        render :action => 'new'
      end
    else
      flash[:error] = "The video was not saved..."
      new
      render :action => 'new'
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

  def attach
    @video = Video.find(params[:id])

    base_dir = "#{RAILS_ROOT}/../../../source/"
    file = "#{@video.id}.mp4"
    full_file = "#{base_dir}#{@video.event.short_code}/#{file}"

    if File.exists?(full_file)
      a = Asset.new
      a.data = File.new(full_file)

      a.asset_type_id = 1

      @video.assets << a

      @video.save
      flash[:success]="File: #{full_file} was attached to #{@video.title}"
    else
      flash[:error] = "File: #{full_file} does not exist"
    end

    redirect_to video_path(@video)
  end
end
