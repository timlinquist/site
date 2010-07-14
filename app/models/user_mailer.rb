class UserMailer < ActionMailer::Base
  REPLY_TO = "LA Ruby Conf <staff@larubyconf.com"

  def welcome_email user
    recipients         user.email
    from               REPLY_TO
    subject            "Welcome to the confreaks.net web-site"
    sent_on            Time.zone.now
    body(              {:user => user, :url => new_session_url } )
  end

  def reset_email user, password
    recipients         user.email
    from               REPLY_TO
    subject            "Your confreaks.net password has been reset"
    sent_on            Time.zone.now
    body(              {:user => user, :password => password } )
  end
end
