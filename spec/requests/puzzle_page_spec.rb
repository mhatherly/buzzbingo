require 'spec_helper'

describe "puzzle page" do
  subject {page}
  before(:each) do
    visit puzzle_path
  end

   describe "has the standard features of this app's pages" do
      it_behaves_like "Standard_Web_Page"
   end
  
  it "gives an error display of some sort when there is not enough data" do
     page.should have_content "SORRY! Not Enough Buzzwords"
  end
  describe "with sufficient data" do
   before do
      24.times do  |i|
       FactoryGirl.create(:buzzword, 
           phrase: "Request Test number #{i+1}").save
      end
      visit puzzle_path
   end
  
   it "has 25 data cells"  do
     puzzle_table_xpath = '//table[@id="puzzle"]'
     last_cell =  '//tr[5]/td[4]'  # start count at 0 for xpaths like arrays
     xpath =  puzzle_table_xpath + last_cell
     page.should have_xpath(xpath)
    end
     
   it "has a center cell marked  as free" do
     puzzle_table_xpath = '//table[@id="puzzle"]'
     center_cell =  
        '//tr[3]/td[3]//text()[contains(.,"FREE")]' # does not count th rouw
        
     xpath =  puzzle_table_xpath + center_cell
     page.should have_xpath(xpath)
   end
  
   it "has a button to generate another page" do
       page.should have_link('Give me another Bingo Card!', href: puzzle_path) 
    end
     
   describe "generate button gives a different grid" do
     it "has a different element in three cells" do
      
      t = page.first(:css,'table#puzzle') # Gives a capybara node of the table
      c1 = t.first(:xpath, '//tr[1]/td[1]').text 
      c2  = t.first(:xpath, '//tr[3]/td[1]').text
      c3 =  t.first(:xpath, '//tr[4]/td[5]').text
      c123 = c1 + c2 + c3
      page.first(:css, 'a#generate').click
      t = page.first(:css,'table#puzzle') 
      c1 = t.first(:xpath, '//tr[1]/td[1]').text 
      c2  = t.first(:xpath, '//tr[3]/td[1]').text
      c3 =  t.first(:xpath, '//tr[4]/td[5]').text
      after_c123 = c1 + c2 + c3
      after_c123.should_not == c123
     end
   end  
 end
end
