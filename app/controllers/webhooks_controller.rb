class WebhooksController < ApplicationController
  def create
    Webhooks::ProcessService.call(params.slice(:Type, :From))

    head :created
  end
end
