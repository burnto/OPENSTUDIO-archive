class Member < ActiveRecord::Base
  has_many :created, :foreign_key => "creator_id", :class_name => "Piece"
  has_many :owned, :foreign_key => "owner_id", :class_name => "Piece"
  
  default_scope :order => "name asc, login asc"

end
