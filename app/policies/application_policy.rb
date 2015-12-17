class ApplicationPolicy
  attr_reader :user, :wiki

  def update?
    user.present?
  end
