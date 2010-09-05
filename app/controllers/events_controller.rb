require 'rdiscount'

class EventsController < ApplicationController

  def index
    @events = Event.find(:all, :order => 'start_at desc')
    render :layout => 'admin'

  end

  def show
    @event = Event.find_by_identifier(params[:id])
  end
end
