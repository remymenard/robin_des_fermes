module Payments
  class OrderPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end

    def create?
      record.buyer == user || user.admin?
    end

    def show?
      create?
    end

    def successful?
      create?
    end

    def canceled?
      create?
    end
  end
end
