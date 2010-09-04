class Admin::PresentersController < Admin::Controller
  layout "admin"

  def index
    @alpha = params[:alpha].blank? ? "%" : params[:alpha]

    conditions = []
    params[:alpha] ? (conditions << "last_name like '#{params[:alpha]}%'") : nil

    @presenters = Presenter.paginate(:all,
                                     :order => 'last_name, first_name',
                                     :conditions => conditions.join(" and"),
                                     :page => params[:page])
  end

  def new
    @presenter = Presenter.new
  end

  def edit
    @presenter = Presenter.find(params[:id])
  end

  def create
    @presenter = Presenter.create params[:presenter]

    if @presenter
      flash[:success] = "Presenter has been created."
    else
      flash[:error] = "Presenter was not created: " +
        @presenter.errors.full_messages.to_sentence
    end

    if params[:commit] == "Save"
      redirect_to admin_presenters_path
    else
      redirect_to new_admin_presenter_path
    end
  end

  def update
    @presenter = Presenter.find(params[:id])

    @presenter.attributes = params[:presenter]

    if @presenter.save
      flash[:success]="Presenter changes saved successfully."
    else
      flash[:error]="Presenter changes could not be saved: " +
        @presenter.errors.full_messages.to_sentence
    end

    redirect_to admin_presenters_path
  end

  def destroy
    @presenter = Presenter.find(params[:id])

    if @presenter.destroy
      flash[:success]="Presenter successfully deleted from the system."
    else
      flash[:error]="Failed to delete the presenter: " +
        @presenter.errors.full_messages.to_sentence
    end

    redirect_to admin_presenters_path
  end
end
