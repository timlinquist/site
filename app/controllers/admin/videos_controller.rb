class Admin::VideosController < ApplicationController

  layout "admin"

  def index
    @videos = Video.paginate(:all, 
                             :order => "recorded_at desc",
                             :page => params[:page])
  end

  def edit
    # TODO: Sort by Conference.name then Year desc
    @events = Event.find(:all,
                         :order => "start_at desc")

    @video = Video.find(params[:id])
    @presenters = Presenter.find(:all, :order => 'last_name, first_name')
  end

  def new
    # TODO: Sort by Conference.name then Year desc
    @events = Event.find(:all,
                         :order => "start_at desc")
    @video = Video.new
    @video.presentations.build
    @presenters = Presenter.find(:all, :order => 'last_name, first_name')

    @event = Event.find(params[:event_id])

  end

  def create
    @video = Video.create(params[:video])

    if @video.save then
      flash[:success] = "The video was created successfully."

      if params[:from] == "Events"
        redirect_to admin_event_path @video.event
      else
        redirect_to admin_videos_path
      end
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

    redirect_to admin_videos_path
  end

  def destroy
    @video = Video.find(params[:id])

    if @video.destroy
      flash[:success]="The video was successfully deleted."
    else
      flash[:error]="The video could not be deleted: " +
        @video.errors.full_messages.to_sentence
    end
    redirect_to admin_videos_path
  end
end
