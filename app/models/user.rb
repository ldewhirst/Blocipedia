class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  after_initialize :init

  def init
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]

  def downgrade
    self.update_attribute(role: :standard)
    flash[:alert] = "Note: all private wikis you've created will become public upon downgrade"
    @wikis.user.private? == @wikis.public
  end

end
