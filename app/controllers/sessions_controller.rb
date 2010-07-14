class SessionsController < ApplicationController
  before_filter :create_login, :only => %w(new create)
  before_filter :require_user, :only => :destroy

  def show
    redirect_to new_session_path
  end

  def create
    if session.user = User.authenticate(@login.username, @login.password)
      token = session.user.remember!
      cookies[:remember] = { :value => token, :expires => 2.weeks.from_now }

      redirect_to session.pop_bookmark || root_path
    else
      @login.password = nil
      flash.now[:error] = "Invalid username or password."

      render :template => '/sessions/new'
    end
  end

  def new
  end

  def destroy
    cookies.delete :remember
    session.user.forget!
    session.reset

    redirect_to root_path
  end

  def reset
    unless params[:email].blank?
      user = User.find_by_email params[:email]

      if user
        password = (10_000_000_000 + rand(10_000_000_000)).to_s(36)
        user.password_reset password
      end

      flash.now[:notice] = "Your new password has been emailed to you."
      render :template => 'sessions/new'
    else
      flash.now[:error] = "You must enter an email address for us to reset your password."
    end
  end

  private

  def create_login
    @login = Transient::Login.new params[:login]
  end

end
