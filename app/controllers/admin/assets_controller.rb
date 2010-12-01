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

    # Generate the Json template to be posted to ZenCoder
    @json_data = Confreaks::Renderer.new(template_file, binding).render

  end
end
