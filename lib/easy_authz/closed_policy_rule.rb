# frozen_string_literal: true

module EasyAuthz
  class ClosedPolicyRule
    def self.authorized?(_user, _controller, _options)
      false
    end
  end
end
