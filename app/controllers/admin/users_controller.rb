class Admin::UsersController < Admin::Controller
  layout "admin"

  def index
    @users = User.paginate(:all,
                           :order => 'username',
                           :page => params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.signup params[:user]

    redirect_to admin_users_path
  end

  def update
    @user = User.find(params[:id])

    @user.attributes = params[:user]

    if @user.save
      flash[:success]="User changes saved successfully."
    else
      flash[:error]="User changes could not be saved: " +
        @user.errors.full_messages.to_sentence
    end

    redirect_to admin_users_path

  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:success] = "User successfully deleted from the system."
    else
      flash[:error] = "Failed to delete user: " + 
        @user.errors.full_messages.to_sentence
    end

    redirect_to admin_users_path
  end
end
