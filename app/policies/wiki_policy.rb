class WikiPolicy < ApplicationPolicy

  def updated?
    user.present?
  end
end
