require 'spec_helper'

describe "buzzword find_random"  do
  before(:all) do
    20.times  do |i|
     FactoryGirl.create(:buzzword, phrase: "test phrase #{i + 1}").save 
    end 
  end #before all
  describe "single selects" do
     before do 
      @count = Hash.new{|h,k| h[k] = 0 }
      1000.times do 
         b = Buzzword.find_random(1) 
         @count[b.first.id] +=1  unless b.nil?
      end # times
     end # before
  
     it "are evenly distributed"  do
         @count.each do |i, ct| 
         puts ct.to_s
         ct.should be_within(20).of(1000/20)
       end # count each
     end # it are
   end # single selects  
  describe "multi select" do
    describe "handles not enough data" do
      it "returns null" do
        Buzzword.find_random(21).should be_nil
      end
    end
    describe "gives random" do
        before do 
          @count = Hash.new{|h,k| h[k] = 0 }
          1000.times do 
            b = Buzzword.find_random(2) 
            unless b.nil? 
               b.each do |z|
                 @count[z.id] += 1  unless z.nil?
               end #b.each
            end #unless
          end #1000
        end # before
        it "are evenly distributed"  do
           @count.each do |i, ct| 
             puts ct.to_s
             ct.should be_within(40).of(2000/20)
           end # @count each
        end # it are
       end # multi  
    end #are random  
  after(:all) do
     Buzzword.all.each do |b|
       b.delete
    end 
  end # after
end # describe     
