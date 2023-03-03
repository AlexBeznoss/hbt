require "test_helper"

class Webhooks::ProcessServiceTest < ActiveSupport::TestCase
  describe "when type is SpamNotification" do
    describe "when email blank" do
      test "raises error" do
        payload = {Type: "SpamNotification", From: ""}
        expected_error_message = "From can't be blank when Type is SpamNotification"

        assert_raises Webhooks::ProcessService::PayloadInvalid, expected_error_message do
          Webhooks::ProcessService.call(payload)
        end
      end
    end

    test "enqueue NotifyJob with email" do
      email = "fake@fake.com"
      payload = {Type: "SpamNotification", From: email}

      assert_changes "NotifyJob.jobs.size", from: 0, to: 1 do
        Webhooks::ProcessService.call(payload)
      end
      assert_equal [email], NotifyJob.jobs.last["args"]
    end
  end

  describe "when other type" do
    test "not enqueue NotifyJob" do
      payload = {Type: "HardBounce"}

      assert_no_changes "NotifyJob.jobs.size" do
        Webhooks::ProcessService.call(payload)
      end
    end
  end
end
