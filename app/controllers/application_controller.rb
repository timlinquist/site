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
end
