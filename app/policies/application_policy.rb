class ApplicationPolicy


  def update?
    user.present?
  end
end
