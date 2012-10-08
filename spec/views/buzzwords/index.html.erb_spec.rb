require 'spec_helper'

describe "buzzwords/index" do
  before(:each) do
    assign(:buzzwords, [
      stub_model(Buzzword,
        :phrase => "Phrase"
      ),
      stub_model(Buzzword,
        :phrase => "Phrase"
      )
    ])
  end

  it "renders a list of buzzwords" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phrase".to_s, :count => 2
  end
end
