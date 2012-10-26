require 'spec_helper'

describe Buzzword do
  before do
  @buzzword = Buzzword.new(phrase: "Lorem Ipsum") 
  end
  
  subject { @buzzword }
  
  it { should respond_to(:phrase) }
  it { should respond_to(:id) }
  it { should be_valid }
  describe "when phrase is empty"  do
   before { @buzzword.phrase = nil }
   it {should_not be_valid}
  end
  
    
  describe "when phrase is too long" do
   before do
    max_length = 66
    @buzzword.phrase = "a" * (max_length + 1)
   end
   
   it {should_not be_valid}
  end
  
  describe "Gets a random set for puzzle" do
    before (:each) do
       
       23.times  do |i|
          @buzzwordr = FactoryGirl.create(:buzzword, phrase: "test phrase #{i +1}") 
          @buzzwordr.save
         end 
    end
    describe "with too few records" do
      it "should return nil " do
        a = Buzzword.random_puzzle_set
        a.should be_nil
      end
    end
    
    describe "with enough records" do
      before do
        FactoryGirl.create(:buzzword, 
              phrase: "Test phrase to fill puzzle").save 
      end
      it "generates 24 buzzwords" do
         a = Buzzword.random_puzzle_set
         a.count.should == 24
      end
         
      it "does not have any duplicates" do
        a = Buzzword.random_puzzle_set
        dupcheck = Hash.new{|h,k| h[k] = 0 }
        a.each do |b|
          dupcheck[b] += 1  unless b.nil?
        end
        dupcheck.each do |i, ct| 
          ct.should == 1
        end
           
      end
    end
      
  end  
end
