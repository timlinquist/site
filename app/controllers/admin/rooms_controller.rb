class Admin::RoomsController < ApplicationController
  layout "admin"

  def index
    if param[:event_id]
      @rooms = Room.find(:all, :condition => ['event_id = ?',param[:event_id]])
    else
      @rooms = Room.find(:all)
    end
  end
end
