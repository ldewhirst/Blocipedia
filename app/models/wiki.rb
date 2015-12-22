class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :publicly_viewable, -> { where(public: true) }
  scope :privately_viewable, -> { where(public: false) }

  scope :visible_to, -> (user) { user ? all : publicly_viewable }

  default_scope { order("created_at DESC") }

  def public?
    self.private == false
  end

  def private?
    self.private == true
  end

end
