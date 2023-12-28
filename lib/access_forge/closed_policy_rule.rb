# frozen_string_literal: true

module AccessForge
  class ClosedPolicyRule
    def self.authorized?(_user, _controller, _options)
      false
    end
  end
end
