class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  has_many :wikis
  has_many :collaborations
  has_many :wiki_collaborations, through: :collaborators, source: :wiki


  after_initialize :init

  def init
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]

end
