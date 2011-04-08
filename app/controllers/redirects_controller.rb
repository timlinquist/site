class RedirectsController < ApplicationController

  def index
    @event = Event.find_by_identifier(params[:redirect_id])
    redirect_to event_path(@event), :status => 301
  end

  def show
    process_redirect "page"
  end

  def file_redirect
    process_redirect "file"
  end

  private

  def process_redirect type
    @event = Event.find_by_identifier(params[:redirect_id])

    case @event.short_code
    when "agileroots2009"
      if type == "page"
        process_page_redirect
      elsif type == "file"
        process_file_redirect_based_on_date
      end
    when "mwrc2010"
      if type == "page"
        process_page_redirect
      elsif type == "file"
        process_file_redirect_based_on_date
      end
    else
      render :text => 'redirect not support'
    end
  end

  def process_file_redirect_based_on_date
    redirect_event_block @event do |video|
      video.assets.each do |asset|
        if asset.data_file_name =~ /#{params[:id]}/
          redirect_to asset.data.url, :status => 301 and return
        end
      end
    end
  end

  def process_page_redirect
    redirect_event_block @event do |video|
      redirect_to video_path(video), :status => 301 and return
    end
  end

  def date_from_params
    parts = params[:id].split('-')
    date = Time.parse("#{parts[2]}-#{parts[1]}-#{parts[0]} #{parts[3]}:#{parts[4]}")
    return date
  end

  def redirect_event_block(event,&blk)
    date = date_from_params
    event.videos.each do |video|
      if video.recorded_at == date
        yield video
      end
    end
  end
end
