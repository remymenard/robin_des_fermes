class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # user.confirmed? || user.admin?
    true || user.admin?
  end

  def show?
    record.buyer == user || user.admin?
    # order.buyer == user || user.admin?
  end

  # private
  # def order
  #   record
  # end
end
