class PresentersController < ApplicationController
  def index
    @presenters = Presenter.paginate(:all, 
                                     :order => 'last_name, first_name',
                                     :limit => 10,
                                     :page => params[:page])
  end

  def show
    @presenter = Presenter.find(params[:id])
  end
end
