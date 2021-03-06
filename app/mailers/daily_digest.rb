class DailyDigest < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_digest.digest.subject
  #
  def digest
    @user = user
    @question = Question.all

    mail to: @user.email, subject: "Daily digest is coming"
  end
end
