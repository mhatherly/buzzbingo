require 'spec_helper'

describe "Help page" do
  subject {page}
  before(:each) { visit help_path }
  
  describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
    end
    
  pending ("has helpful stuff")
end
