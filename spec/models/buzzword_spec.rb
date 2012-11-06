require 'spec_helper'

describe Buzzword do
  describe "Buzzword methods" do
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
      
      describe 'it should not be the word "FREE"' do
        before do
         @buzzword.phrase = "free"
        end 
        it {should_not be_valid}
      end 
   end
  describe "Buzzwords methods" do
      before (:all) do
           
           23.times  do |i|
              @buzzwordr = FactoryGirl.create(:buzzword, phrase: "test phrase #{i +1}") 
              @buzzwordr.save
             end 
        end
      describe "Gets a random set for puzzle" do
        
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
             @puzzle = Buzzword.random_puzzle_set
          end

          it "returns an array" do
            
            @puzzle.class.to_s.should == "Array"
          end
          it "of text strings" do
                   @puzzle.each do |p|
                 p.class.to_s.should == "String"
              end   
           end 
           it "with no duplicates" do
           
            dupcheck = Hash.new{|h,k| h[k] = 0 }
            @puzzle.each do |b|
              dupcheck[b] += 1  unless b.nil?
            end
            dupcheck.each do |i, ct| 
              ct.should == 1
            end
               
          end 
          describe "if the free space  option is false" do  
            let(:puzzle2) {Buzzword.random_puzzle_set(free_space: false) }   
            it "should have  24 phrases" do
               puzzle2.count.should == 24
            end
            it "and should not have a value free" do
              puzzle2.should_not include("FREE")
            end
          end
           describe "if the free space option is true" do  
            let(:puzzle3) {Buzzword.random_puzzle_set(free_space: true) }   
            it "should have  25 phrases" do
               puzzle3.count.should == 25
            end
            it "and should  have a value free" do
              puzzle3[12].should == "FREE"
            end
          end
 
          describe "if the free space option not boolean" do  
             it "should give a type error" do
               expect { Buzzword.random_puzzle_set(
                 free_space: "XXX") }.to raise_error(TypeError)
            end
           end
          
          
          describe "if the free space  option default is taken" do      
            it "should have  25 phrases" do
               @puzzle.count.should == 25
            end
            it "has FREE in the middle" do
              @puzzle[12].should == "FREE"
            end
          end
        end
          
      end
      after(:all) do
        Buzzword.all.each do |b|
         b.delete
        end 
      end # after
   end     
end
