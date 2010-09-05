class MainController < ApplicationController
  def home_page
    @video = Video.random

    @p = Confreaks::ParseUserAgent.new

    @p.parse request.env["HTTP_USER_AGENT"]

    @player = params[:player] || "html5"

  end
end
