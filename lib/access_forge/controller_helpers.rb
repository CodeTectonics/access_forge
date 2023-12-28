# frozen_string_literal: true

module AccessForge
  module ControllerHelpers
    def authorize_user!
      policy = policy_class.new(current_user, self)
      return if policy.send("#{action_name}?")

      render json: { error: "You are not authorized to perform this action" },
             status: :unauthorized
    end

    def policy_class
      "#{controller_name.classify}Policy".constantize
    end
  end
end
