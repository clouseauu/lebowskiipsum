class Character < ActiveRecord::Base
  attr_accessible :is_main, :name, :short_name
  has_many :quotes

end
