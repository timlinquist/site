class Admin::EventsController < Admin::Controller
  layout  'admin'

  def index
    @events = Event.paginate(:all,
               :order => 'start_at desc',
               :page => params[:page])
  end

  def new
    @event = Event.new
    @conferences = Conference.find(:all, :order => 'name')
  end

  def edit
    @event = Event.find(params[:id])
    @conferences = Conference.find(:all, :order => 'name')
  end

  def show
    @event = Event.find(params[:id])
    render :template => 'events/show'
  end

  def create
    @event = Event.create params[:event]

    redirect_to admin_events_path
  end

  def update
    @event = Event.find(params[:id])

    @event.attributes = params[:event]

    if @event.save
      flash[:success]="Event changes saved successfully."
    else
      flash[:error]="Event changes could not be saved: " + 
        @event.errors.full_messages.to_sentence
    end

    redirect_to admin_events_path
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      flash[:success]="Event successfully deleted from the system."
    else
      flash[:error] = "Failed to delete the event: " + 
        @event.errors.full_messages.to_sentence
    end

    redirect_to admin_events_path
  end
end
