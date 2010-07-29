class Admin::AssetTypesController < Admin::Controller
  layout 'admin'

  def index
    @asset_types = AssetType.paginate(:all,
                                      :order => 'name',
                                      :page => params[:page])
  end

end
