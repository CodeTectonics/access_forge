# frozen_string_literal: true

module EasyAuthz
  class Policy
    def initialize(user, controller)
      @user = user
      @controller = controller
      @params = @controller.request.params
      @headers = @controller.request.headers
    end

    def authorized?(rules, options = {})
      rules.each do |rule|
        return true if rule.authorized?(@user, @controller, options)
      end
      false
    end

    def index?
      can_read?
    end

    def show?
      can_read?
    end

    def new?
      create?
    end

    def create?
      can_write?
    end

    def edit?
      update?
    end

    def update?
      can_write?
    end

    def delete?
      destroy?
    end

    def destroy?
      can_write?
    end

    def can_read?
      authorized?([PolicyRules::ClosedPolicyRule])
    end

    def can_write?
      authorized?([PolicyRules::ClosedPolicyRule])
    end
  end
end
