class EventsController < ApplicationController

  def index
    @events = Event.find(:all, :order => 'start_at desc')
  end

  def show
    @event = Event.find(params[:id])
  end
end
