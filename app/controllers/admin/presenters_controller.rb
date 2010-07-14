class Admin::PresentersController < ApplicationController
  layout "admin"

  def index
    @presenters = Presenter.paginate(:all,
                                     :order => 'last_name, first_name',
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

    redirect_to admin_presenters_path
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
