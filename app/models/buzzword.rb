class Buzzword < ActiveRecord::Base
  attr_accessible :phrase
  validates :phrase, presence: true, uniqueness: true, 
            :length => { :maximum => 66 }
end
