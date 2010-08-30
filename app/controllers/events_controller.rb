class EventsController < ApplicationController

  def index
    @events = Event.find(:all, :order => 'start_at desc')
  end

  def show
    @event = Event.find_by_identifier(params[:id])
  end
end
