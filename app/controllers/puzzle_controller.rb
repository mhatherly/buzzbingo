
class PuzzleController < ApplicationController
  def puzzle
     @buzzwords = Buzzword.random_puzzle_set
    render "puzzle" 
  end
end
