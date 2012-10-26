require 'spec_helper'

describe "puzzle page" do
  subject {page}
  before(:each) do
    visit puzzle_path
  end
  
  it "dummy test keep in to end" do
     page.should have_content("BLAH")
  end
  
   describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end

  
  it "gives an error display of some sort when there is not enough data" do
   pending ("not enough data test") 
  end
  
  it "has 25 data cells"  do
     pending("how to count")
  end
  
  it "has a center cell counted as free" do
      pending("how to find center cell") 
  end
  
  it "has a button to generate another page" do
     pending("button")
  end
  
  describe "generates button gives a different grid" do
     pending("alter grid") 
  end
  
end
