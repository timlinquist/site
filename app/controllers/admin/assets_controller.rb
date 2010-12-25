require 'zencoder'

class Admin::AssetsController < Admin::Controller
  layout "admin"

  def index
    @assets = Asset.find(:all, :order => 'created_at desc')
  end

  # Submit this asset to ZenCoder for preparation
  def encode
    @asset = Asset.find(params[:id])

    @asset.data.url

    template_file = "#{RAILS_ROOT}/lib/templates/zencoder-job-template.erb"
    @base_file_name = @asset.video.to_param

    # Generate the Json template to be posted to ZenCoder
    @json_data = Confreaks::Renderer.new(template_file, binding).render

    @response = Zencoder::Job.create(@json_data)
  end

  def refresh_meta_data
    a = Asset.find(params[:id])

    a.width, a.height, a.duration = a.get_metadata

    a.save

    redirect_to video_path(a.video)
  end
end
