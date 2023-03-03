Slack.configure do |config|
  config.token = Rails.application.credentials.dig(:slack, :token)
end
