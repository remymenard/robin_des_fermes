def PagePolicy < ApplicationPolicy
  def home?
    true
  end

  def cgv?
    true
  end

  def faq?
    true
  end
end
