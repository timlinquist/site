class Admin::ConferencesController < ApplicationController
  layout "admin"

  def index
    @conferences = Conference.paginate(:all,
                                       :order => 'name',
                                       :page => params[:page])
  end

  def new
    @conference = Conference.new
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def create
    @conference = Conference.create params[:conference]

    redirect_to admin_conferences_path
  end

  def update
    @conference = Conference.find(params[:id])

    @conference.attributes = params[:conference]

    if @conference.save
      flash[:success]="Conference changes saved successfully."
    else
      flash[:error]="Conference changes could not be saved: " +
        @conference.errors.full_messages.to_sentence
    end

    redirect_to admin_conferences_path
  end

  def destroy
    @conference = Conference.find(params[:id])

    if @conference.destroy
      flash[:success] = "Conference successfully deleted from the system."
    else
      flash[:error] = "Failed to delete the conference: " +
        @conference.errors.full_messages.to_sentence
    end

    redirect_to admin_conferences_path
  end
end
