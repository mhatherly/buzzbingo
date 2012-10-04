shared_examples_for "Standard_Web_Page" do
  
  it "has a title"  do
    page.should have_selector('title', text: "Buzzword Bingo") 
  end
  
  
  it "has a logo" do 
     page.should have_xpath(
       "//div[@id='logo']/img[(@id = 'logo_image') and (@src = '/assets/bblogo.png')]"
       )
  end
    
  describe "with a navigation bar" do
     #it "that points to the Buzzword maint page" do
       #page.should have_link("buzzwords", href: buzzwords_path)
    #end
    
    
    it "that points to the Tech Info page" do
       page.should have_link('Tech Info', href: tech_path)
              
    end
    
    it "that points to the Help page" do
       page.should have_link('Help', href: help_path)
              
    end
   end  #nav bar
end #  standard features



 
 

       

