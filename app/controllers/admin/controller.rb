class Admin::Controller < ApplicationController

  before_filter :require_user
  before_filter :require_admin_user

  def require_admin_user
    if session.user.admin?
      true
    else
      redirect_to :home
    end
  end

end
