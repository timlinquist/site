class UserMailer < ActionMailer::Base
  # FIXME: lots of refs to la ruby conf in this and the views
  default :from => "LA Ruby Conf <staff@larubyconf.com"

  def welcome_email user
    @user = user
    @url = new_session_url

    mail :to => user.email, :subject => "Welcome to the confreaks.net web-site"
  end

  def reset_email user, password
    @user = user
    @password = password
    @url = new_session_url

    mail :to => user.email, :subject => "Your confreaks.net password has been reset"
  end
end
