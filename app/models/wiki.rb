class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  after_initialize :set_public

  scope :publicly_viewable, -> { where(private: false) }
  scope :privately_viewable, -> { where(private: true) }
  scope :order_by_recently_created, -> { order(created_at: :desc) }

  scope :visible_to, -> (user) { (user.present? && (user.premium? || user.admin?)) ? all : (publicly_viewable) }

  def should_generate_new_friendly_id?
    new_record?
  end

  def public?
    self.private == false
  end

  def private?
    self.private == true
  end

  private
    def set_public
      self.private ||= false
    end
end
