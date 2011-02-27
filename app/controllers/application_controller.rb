require 'uuid'
require 'intercession'

class ApplicationController < ActionController::Base
  include Intercession

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection
                       # for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :set_time_zone

  before_filter :log_history

  protected

  def require_user
    if session.anonymous?
      flash[:error] = "You must be logged in for that!"
      session.bookmark = url_for params

      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
  end

  def set_time_zone
    unless session.anonymous? || session.user.time_zone.blank?
      Time.zone = session.user.time_zone
    end
  end

  def log_history
    h = History.new

    h.controller = params[:controller]
    h.action = params[:action]
    h.ip_address = request.remote_ip
    h.referrer = request.referrer
    unless session.anonymous?
      h.user_id = session.user.id
    end
    h.param_id = params[:id].to_i
    h.uri = request.request_uri
    h.url = request.url
    h.http_method = request.request_method
    h.query_string = request.query_string
    h.protocol = request.protocol
    h.user_agent = request.user_agent
    h.save
  end

  def recents
    @recent_events = Event.active.find(:all,
                                       :order => 'start_at desc',
                                       :limit =>5)

    @recent_videos = @recent_events.map {|event| event.videos.first}
  end
end
