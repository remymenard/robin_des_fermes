class OrderLineItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def increment?
    true
  end

  def decrement?
    true
  end

  def destroy?
    true
  end

  def basket_modal?
    true
  end
end
