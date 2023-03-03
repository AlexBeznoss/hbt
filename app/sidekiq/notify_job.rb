class NotifyJob
  include Sidekiq::Job

  def perform(email)
    text = "New spam report about `#{email}` received!"
    Slack::Web::Client.new.chat_postMessage(text:, channel:)
  end

  private

  def channel
    Rails.application.credentials.dig(:slack, :channel)
  end
end
