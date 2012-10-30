require 'spec_helper'

#
 describe PuzzleController do
 
  describe "GET #puzzle" do
   # not quite sure how to test the array here. So I just do a count
   it "populates an array of puzzle buzzwords" do
    buzzwords = []
    24.times do |i|
       buzzwords[i] = FactoryGirl.create(:buzzword, phrase: "Controller Test #{i +1}")
    end  
    get :puzzle
    assigns(:buzzwords).count.should eq(buzzwords.count)
    
   end
   it "renders the puzzle view" do
    get :puzzle
    response.should render_template :puzzle
   end
 end  
end
