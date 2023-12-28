# frozen_string_literal: true

RSpec.describe AccessForge::ClosedPolicyRule do
  describe "::authorized?" do
    it "should return false" do
      expect(AccessForge::ClosedPolicyRule.authorized?(nil, nil, nil)).to be_falsy
    end
  end
end
