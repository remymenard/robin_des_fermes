module Webhooks
  class BaseController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    skip_after_action :verify_authorized
    skip_after_action :verify_policy_scoped
  end
end
