class FarmPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin?
  end

  def index?
    true
  end

  def show?
    record.active
  end

  def products_list?
    record.active
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
