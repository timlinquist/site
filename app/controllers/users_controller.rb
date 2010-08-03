class UsersController < ApplicationController
  before_filter :require_user, :except => %w[create new show]

  def new
    redirect_to user_path(session.user) if session.authenticated?
    @user = User.new
    @presenters = Presenter.find(:all,:order => 'last_name, first_name')
  end

  def create
    @user = User.signup params[:user]

    if @user.valid?
      session.user = @user
      redirect_to root_path
    else
      flash[:error] = "Errors: #{@user.errors.full_messages.to_sentence}"
      render :template => 'users/new'
    end
  end

  def destroy
    session.user.destroy

    redirect_to home_path
  end

  def edit
    @user = User.find(params[:id])
    require_session_user @user
    @presenters = Presenter.find(:all,:order => 'last_name, first_name')
  end

  def settings
    @user = session.user
  end

  def show
    @user = User.find(params[:id])
    @presenters = Presenter.find(:all,:order => 'last_name, first_name')
  end

  def update
    @user = User.find(params[:id])

    require_session_user @user

    @user.attributes = params[:user]

    if @user.save then
      flash[:success] = "Your user profile changes have been saved successfully."
    else
      flash[:error] = "Failed to save your changes: " +
        @user.errors.full_messages.to_sentence
    end

    redirect_to user_path @user
  end

  private

  def require_session_user user
    if session.anonymous? || session.user != user
      flash[:error] = "You can not do this to another persons profile!"
      redirect_to user_path session.user
    end
  end

end
