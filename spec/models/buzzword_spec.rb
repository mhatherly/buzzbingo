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
end
