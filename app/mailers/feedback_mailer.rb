class FeedbackMailer < ActionMailer::Base
  default from: user.email

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.user_feedback.subject
  #
  def user_feedback(user)
    @greeting = user

    mail to: "getjoocy@gmail.com", subject: "User feedback from #{user.email}"
  end
end
