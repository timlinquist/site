class RedirectsController < ApplicationController
  def show
    @event = Event.find_by_identifier(params[:redirect_id])

    case @event.short_code
    when "agileroots2009"
      parts = params[:id].split('-')
      date = Time.parse("#{parts[2]}-#{parts[1]}-#{parts[0]} #{parts[3]}:#{parts[4]}")
      @event.videos.each do |video|
        if video.recorded_at == date
          redirect_to video_path(video), :status => 301
        end
      end
    else
      render :text => 'redirect not support'
    end
  end

  def file_redirect
    @event = Event.find_by_identifier(params[:redirect_id])

    case @event.short_code
    when "agileroots2009"
      parts = params[:id].split('-')
      date = Time.parse("#{parts[2]}-#{parts[1]}-#{parts[0]} #{parts[3]}:#{parts[4]}")
      @event.videos.each do |video|
        if video.recorded_at == date
          video.assets.each do |asset|
            if asset.data_file_name =~ /#{params[:id]}/
              redirect_to asset.data.url, :status => 301
            end
          end
        end
      end
    else
      render :text => 'redirect not support'
    end

  end
end
