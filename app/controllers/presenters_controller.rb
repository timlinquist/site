class PresentersController < ApplicationController
  def index
    @alpha = params[:alpha].blank? ? "%" : params[:alpha]

    conditions = []
    params[:alpha] ? (conditions << "last_name like '#{params[:alpha]}%'") : nil


    # TODO make this so it only shows presenters with one or more videos
    @presenters = Presenter.paginate(:all,
                                     :order => 'last_name, first_name',
                                     :limit => 10,
                                     :conditions => conditions.join(" and "),
                                     :page => params[:page])
  end

  def show
    @presenter = Presenter.find(params[:id])
  end
end
