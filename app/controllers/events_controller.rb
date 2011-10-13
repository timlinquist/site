require 'rdiscount'

class EventsController < ApplicationController
  layout 'admin'

  def index
    order = 'start_at desc'

    if session.user && session.user.admin?
      @events = Event.find(:all, :order => order)
    else
      @events = Event.active.find(:all, :order => order)
    end
    render :layout => 'admin'
  end

  def show
    @event = Event.find_by_identifier(params[:id])

    @data = params[:id]

    if params[:sort] == 'post'
      if session.user && session.user.admin?
        @videos = @event.videos_posted
      else
        @videos = @event.available_videos_posted
      end
    else
      if session.user && session.user.admin?
        @videos = @event.videos
      else
        @videos = @event.available_videos
      end
    end

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
