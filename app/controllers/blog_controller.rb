class BlogController < ApplicationController
  def index
    redirect_to 'http://blog.confreaks.net', :status => 301
  end
end
