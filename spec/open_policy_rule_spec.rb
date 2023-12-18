# frozen_string_literal: true

RSpec.describe EasyAuthz::OpenPolicyRule do
  describe "::authorized?" do
    it "should return true" do
      expect(EasyAuthz::OpenPolicyRule.authorized?(nil, nil, nil)).to be_truthy
    end
  end
end
