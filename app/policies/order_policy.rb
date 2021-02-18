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

  def review?
    record.buyer == user || user.admin?
    record.status == 'waiting' || user.admin?
    record.status == 'waiting' || record.status == 'failed' || user.admin?
  end

  def delivery?
    record.buyer == user || user.admin?
    record.status == 'waiting' || record.status == 'failed' || user.admin?
  end

  def update_delivery_methods?
    true || user.admin?
  end
end
