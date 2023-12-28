# frozen_string_literal: true

module AccessForge
  class OpenPolicyRule
    def self.authorized?(_user, _controller, _options)
      true
    end
  end
end
