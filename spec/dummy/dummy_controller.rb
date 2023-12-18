# frozen_string_literal: true

class DummyController
  include EasyAuthz::ControllerHelpers

  def policy_class
    DummyPolicy
  end
end
