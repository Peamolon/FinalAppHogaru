class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.report_created.subject
  #
  def report_created(email)
    @token = Report.generate_token
    mail to: email, subject: "Someone has shared with you his progress"
  end
end
