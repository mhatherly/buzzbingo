require 'spec_helper'

describe "buzzwords/show" do
  before(:each) do
    @buzzword = assign(:buzzword, stub_model(Buzzword,
      :phrase => "Phrase"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phrase/)
  end
end
