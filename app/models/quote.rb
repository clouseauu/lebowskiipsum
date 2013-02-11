class Quote < ActiveRecord::Base
  attr_accessible :character_id, :cussin, :quote
  belongs_to :characters


end
