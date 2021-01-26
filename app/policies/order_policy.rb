class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true || user.admin?
  end

  def show?
    record.buyer == user || user.admin?
  end

  def confirmation?
    record.buyer == user || user.admin?
  end
end
