class MainController < ApplicationController
  def home_page
    @random_video = Video.random
  end
end
