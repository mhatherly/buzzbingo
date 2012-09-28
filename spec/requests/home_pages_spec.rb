require 'spec_helper'


describe "Home Page" do
   subject {page}
   before {visit root_path}
   
   
   describe "it should have the standard features of this apps pages" do
     it { should have_content("logo")  }# fix this 
     it { should have_content("have title") } # fix this  
   end
    
    describe "it should have a narrative"  do
      it should { pending("intro to app")}
    end
    
    describe "it should have a link to the help page" do
       it { should have_link("Help",  href: help_path) } 
    end
    
    describe "it should have a link to the maintain buzzwords page" do
       it { should have_link("Buzzword",  href: buzzword_path) } 
    end 
     
     describe "it should have a button to generate a bingo page" do
        it { should have_selector('input', value: 'Generate') }
     end 
     
     describe "it should have a link to the Tech Info page" do
        it { should have_link("Buzzword",  href: tech_path ) } 
     end   
           
              
end
