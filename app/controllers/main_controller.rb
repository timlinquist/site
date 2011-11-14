require 'confreaks/parse_user_agent'

class MainController < ApplicationController
  def home_page
    recents

    if params[:id].nil?
      @video = Video.random
    else
      @video = Video.find(params[:id])
    end

    @p = Confreaks::ParseUserAgent.new

    @p.parse request.env["HTTP_USER_AGENT"]

    @player = params[:player] || "html5"

  end

  def contact
    redirect_to '/contact-us', :status => 301
  end
end
