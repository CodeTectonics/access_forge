# frozen_string_literal: true

class DummyController
  include AccessForge::ControllerHelpers

  def policy_class
    DummyPolicy
  end
end
