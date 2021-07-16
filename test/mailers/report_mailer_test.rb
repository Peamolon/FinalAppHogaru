require "test_helper"

class ReportMailerTest < ActionMailer::TestCase
  test "report_created" do
    mail = ReportMailer.report_created
    assert_equal "Report created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
