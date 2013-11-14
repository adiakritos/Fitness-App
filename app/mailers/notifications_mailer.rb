class NotificationsMailer < ActionMailer::Base

  default :from => "nick@getjoocy.com"
  default :to => "you@youremail.dev"

  def new_message(message)
    @message = message
    mail(:subject => "Feedback:: #{message.subject}")
  end

end
