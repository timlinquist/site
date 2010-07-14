class EventsController < ApplicationController

  def index
    @events = Event.find(:all, :order => 'name_suffix')
  end

  def show
    @event = Event.find(params[:id])
  end
end
