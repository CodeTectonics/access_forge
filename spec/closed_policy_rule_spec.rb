# frozen_string_literal: true

RSpec.describe EasyAuthz::ClosedPolicyRule do
  describe "::authorized?" do
    it "should return false" do
      expect(EasyAuthz::ClosedPolicyRule.authorized?(nil, nil, nil)).to be_falsy
    end
  end
end
