class ConferencesController < ApplicationController
  def index
    @conferences = Conference.find(:all, :order => 'name asc')
  end

  def show
    @conference = Conference.find(params[:id])
  end
end
