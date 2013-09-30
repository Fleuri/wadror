require 'spec_helper'

describe Brewery do
  describe "when initialized with name Schlenkerla and year 1674" do
    subject{ Brewery.create :name => "Schlenkerla", :year => 1674 }

    it "has the name and year set correctly and is saved to database" do

    its.name.should == "Schlenkerla"
    its.year.should == 1674
    it.should be_valid
  end
     end

  it "without a name is not valid" do
    brewery = Brewery.create  :year => 1674

    brewery.should_not be_valid
  end
end

