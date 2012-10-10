require 'spec_helper'

describe "Help page" do
  subject {page}
  before(:each) { visit help_path }
  
  describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
  it "has helpful stuff" do  
   pending " waiting on rest of UI Design"
   
  end
end
