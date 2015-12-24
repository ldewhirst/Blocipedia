class Wiki < ActiveRecord::Base
  belongs_to :user
  after_initialize :set_public

  scope :publicly_viewable, -> { where(private: false) }
  scope :privately_viewable, -> { where(private: true) }
  scope :order_by_recently_created, -> { order(created_at: :desc) }

  scope :visible_to, -> (user) { (user.present? && (user.premium? || user.admin?)) ? all : publicly_viewable }


  private
    def set_public
      self.private ||= false
    end
end
