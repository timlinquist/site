require 'rdiscount'

class EventsController < ApplicationController

  def index
    @events = Event.find(:all, :order => 'start_at desc')
    render :layout => 'admin'
  end

  def show
    recents

    @event = Event.find_by_identifier(params[:id])

    if session.user && session.user.admin?
      # do not redirect
    else
      # redirect if envet is not ready
      unless @event.ready
        redirect_to "http://#{@event.short_code}.confreaks.com", :status => 302
      end
    end
  end
end
