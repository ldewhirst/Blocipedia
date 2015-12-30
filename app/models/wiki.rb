class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :user

  after_initialize :set_public

  scope :publicly_viewable, -> { where(private: false) }
  scope :privately_viewable, -> { where(private: true) }
  scope :order_by_recently_created, -> { order(created_at: :desc) }

  scope :visible_to, -> (user) { (user.present? && (user.premium? || user.admin?)) ? all : (publicly_viewable) }


  def private
    private == true
  end

  def public
    private == false
  end

  private
    def set_public
      self.private ||= false
    end
end
