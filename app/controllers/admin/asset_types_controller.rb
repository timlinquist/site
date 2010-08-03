class Admin::AssetTypesController < Admin::Controller
  layout 'admin'

  def index
    @asset_types = AssetType.paginate(:all,
                                      :order => 'description',
                                      :page => params[:page])
  end

  def new
    @asset_type = AssetType.new
  end

  def edit
    @asset_type = AssetType.find(params[:id])
  end

  def show
    @asset_type = AssetType.find(params[:id])
  end

  def create
    @asset_type = AssetType.create params[:asset_type]

    redirect_to admin_asset_types_path
  end

  def update
    @asset_type = AssetType.find(params[:id])

    @asset_type.attributes = params[:asset_type]

    if @asset_type.save
      flash[:success]="Asset Type changes saved successfully."
      redirect_to admin_asset_types_path
    else
      flash[:error] = "Asset Type changes could not be saved: " +
        @asset_type.errors.full_messages.to_sentence
      redirect_to edit_admin_asset_type_path(@asset_type)
    end
  end

  def destroy
    @asset_type = AssetType.find(params[:id])

    if @asset_type.destroy
      flash[:success] = "Asset Type successfully deleted from the system."
    else
      flash[:error] = "Failed to delete asset type: " +
        @asset_type.errors.full_messages.to_sentence
    end

    redirect_to admin_asset_types_path
  end
end
