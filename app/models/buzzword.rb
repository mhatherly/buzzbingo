class Buzzword < ActiveRecord::Base
  attr_accessible :phrase
  validates :phrase, presence: true, uniqueness: true
end
