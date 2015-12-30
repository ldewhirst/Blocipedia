class Collaboration < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators, source: :wiki
  belongs_to :wiki

end
