class Admin::AssetsController < Admin::Controller
  layout "admin"

  def index
    @assets = Asset.find(:all, :order => 'created_at desc')
  end
end
