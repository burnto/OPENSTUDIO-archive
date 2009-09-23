class Piece < ActiveRecord::Base
  belongs_to :owner, :class_name => "Member"
end
