require 'rdiscount'

class EventsController < ApplicationController
  layout 'admin'

  def index
    if session.user && session.user.admin?
      @events = Event.find(:all, :order => 'start_at desc')
    else
      @events = Event.active.find(:all, :order => 'start_at desc')
    end
    render :layout => 'admin'
  end

  def show
    @event = Event.find_by_identifier(params[:id])

    @data = params[:id]

    #recents

    if @event
      if session.user && session.user.admin?
        # do not redirect
      else
        # redirect if event is not ready
        unless @event.nil? || @event.ready
          redirect_to "http://#{@event.short_code}.confreaks.com", :status => 302
        end
      end
    else
      render :template => '/events/missing_event'
      #redirect_to '/events/missing/?data='+@data
    end
  end
end
