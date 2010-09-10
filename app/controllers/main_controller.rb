class MainController < ApplicationController
  def home_page
    recents

    @video = Video.random

    @p = Confreaks::ParseUserAgent.new

    @p.parse request.env["HTTP_USER_AGENT"]

    @player = params[:player] || "html5"

  end
  def contact
    redirect_to '/contact-us', :status => 301
  end
end
