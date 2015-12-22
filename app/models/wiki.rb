class Wiki < ActiveRecord::Base
  belongs_to :user

  #scope :publicly_viewable, -> { where(private: false) }
  #scope :privately_viewable, -> { where(private: true) }

  scope :visible_to, -> (user) { (user.premium? || user.admin?) ? all : where(private: false) }

  default_scope { order("created_at DESC") }

  def public?
    self.private == false
  end

  def private?
    self.private == true
  end

end
