# frozen_string_literal: true

RSpec.describe AccessForge::OpenPolicyRule do
  describe "::authorized?" do
    it "should return true" do
      expect(AccessForge::OpenPolicyRule.authorized?(nil, nil, nil)).to be_truthy
    end
  end
end
