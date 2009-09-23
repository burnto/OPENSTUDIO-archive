class Piece < ActiveRecord::Base
  belongs_to :owner, :class_name => "Member"
  belongs_to :creator, :class_name => "Member"
  
  named_scope :sold, :conditions => "owner_id != creator_id"
end
