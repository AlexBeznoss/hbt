require "sidekiq"

redis_url = ENV["REDIS_URL"]
Sidekiq.configure_server do |config|
  config.redis = {url: redis_url, network_timeout: 5}
end

Sidekiq.configure_client do |config|
  config.redis = {url: redis_url, network_timeout: 5}
end

Sidekiq.strict_args!
