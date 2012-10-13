require 'spec_helper'

describe "buzzwords/index" do
  before(:each) do
  page = 1
  per_page = 2
  buzzwords1 = 
     [
      stub_model(Buzzword,
        :phrase => "Phrase"
      ),
      stub_model(Buzzword,
        :phrase => "Phrase"
      )
    ]
   total_entries = buzzwords1.count
   @test = 
      WillPaginate::Collection.create(page, per_page, total_entries) do |pager|
           pager.replace(buzzwords1)
      end
    assign(:buzzwords,   @test)
    # for some reason the @est variable is required  to be named in order
    # for this test to work properly otherwise will_paginate craps out.
    
    
  end
  

  

  it "renders a list of buzzwords" do
    render 
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phrase".to_s, :count => 2
  end
end
