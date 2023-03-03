require "test_helper"

class NotifyJobTest < ActiveSupport::TestCase
  test "calls slack to send message" do
    email = "fake@fake.com"
    expected_channel = "fake channel name"
    expected_message = "New spam report about `fake@fake.com` received!"
    slack_token = Rails.application.credentials.dig(:slack, :token)
    expected_headers = {
      "Authorization" => "Bearer #{slack_token}"
    }
    expected_url = "https://slack.com/api/chat.postMessage"
    stub_request(:post, expected_url)

    NotifyJob.perform_sync(email)

    assert_requested(
      :post,
      expected_url,
      body: {
        "channel" => expected_channel,
        "text" => expected_message
      },
      headers: expected_headers
    )
  end
end
