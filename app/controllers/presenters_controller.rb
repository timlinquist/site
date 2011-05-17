class PresentersController < ApplicationController
  def index
    recents

    @alpha = params[:alpha].blank? ? "%" : params[:alpha]

    @sort = params[:sort_order].blank? ? "alpha" : params[:sort_order]

    conditions = []
    params[:alpha] ? (conditions << "last_name like '#{params[:alpha]}%'") : nil

    # TODO make this so it only shows presenters with one or more videos
    @presenters = Presenter.paginate(:all,
                                     :order => 'last_name, first_name',
                                     :limit => 10,
                                     :include => [:videos],
                                     :conditions => conditions.join(" and "),
                                     :page => params[:page])

  end


  def show
    @presenter = Presenter.find(params[:id])
  end
end
