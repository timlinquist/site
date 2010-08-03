class PresentersController < ApplicationController
  def index
    # TODO make this so it only shows presenters with one or more videos
    @presenters = Presenter.paginate(:all, 
                                     :order => 'last_name, first_name',
                                     :limit => 10,
                                     :page => params[:page])
  end

  def show
    @presenter = Presenter.find(params[:id])
  end
end
