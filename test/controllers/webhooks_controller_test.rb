require "test_helper"

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  describe "when type is SpamNotification" do
    test "returns success" do
      post "/webhooks", params: spam_payload

      assert_response :created
      assert_equal 1, NotifyJob.jobs.size
      assert_equal [spam_payload[:From]], NotifyJob.jobs.last["args"]
    end
  end

  describe "when type other than SpamNotification" do
    test "return success" do
      post "/webhooks", params: hard_bounce_payload

      assert_response :created
      assert_equal 0, NotifyJob.jobs.size
    end
  end

  private

  def spam_payload
    {
      RecordType: "Bounce",
      Type: "SpamNotification",
      TypeCode: 512,
      Name: "Spam notification",
      Tag: "",
      MessageStream: "outbound",
      Description: "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
      Email: "zaphod@example.com",
      From: "notifications@honeybadger.io",
      BouncedAt: "2023-02-27T21:41:30Z"
    }
  end

  def hard_bounce_payload
    {
      RecordType: "Bounce",
      MessageStream: "outbound",
      Type: "HardBounce",
      TypeCode: 1,
      Name: "Hard bounce",
      Tag: "Test",
      Description: "The server was unable to deliver your message (ex: unknown user, mailbox not found).",
      Email: "arthur@example.com",
      From: "notifications@honeybadger.io",
      BouncedAt: "2019-11-05T16:33:54.9070259Z"

    }
  end
end
