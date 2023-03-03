module Webhooks
  class ProcessService
    class PayloadInvalid < StandardError; end

    def self.call(...)
      new(...).call
    end

    def initialize(payload)
      @payload = payload
    end

    def call
      validate_payload!

      NotifyJob.perform_async(@payload[:From]) if spam_notification?
    end

    private

    def validate_payload!
      return unless spam_notification?
      return if @payload[:From].present?

      raise PayloadInvalid.new("From can't be blank when Type is SpamNotification")
    end

    def spam_notification?
      @payload[:Type] == "SpamNotification"
    end
  end
end
