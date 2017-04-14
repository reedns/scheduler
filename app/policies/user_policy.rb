class UserPolicy < ApplicationPolicy
  def index?
    user.therapist?
  end

  def destroy?
    user.therapist?
  end

  def show?
    user.id == record.id
  end
end
