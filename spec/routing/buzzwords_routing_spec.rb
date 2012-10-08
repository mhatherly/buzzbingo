require "spec_helper"

describe BuzzwordsController do
  describe "routing" do

    it "routes to #index" do
      get("/buzzwords").should route_to("buzzwords#index")
    end

    it "routes to #new" do
      get("/buzzwords/new").should route_to("buzzwords#new")
    end

    it "routes to #show" do
      get("/buzzwords/1").should route_to("buzzwords#show", :id => "1")
    end

    it "routes to #edit" do
      get("/buzzwords/1/edit").should route_to("buzzwords#edit", :id => "1")
    end

    it "routes to #create" do
      post("/buzzwords").should route_to("buzzwords#create")
    end

    it "routes to #update" do
      put("/buzzwords/1").should route_to("buzzwords#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/buzzwords/1").should route_to("buzzwords#destroy", :id => "1")
    end

  end
end
