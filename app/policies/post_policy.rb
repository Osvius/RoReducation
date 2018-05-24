class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    true if user.present? && (user == post.user || user.admin?)
  end

  def destroy?
    true if user.present? && (user == post.user || user.admin?)
  end

  private
  def post
    record
  end
end