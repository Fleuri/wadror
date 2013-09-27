require 'spec_helper'

describe Beer do
  it "isn't saved without a name" do
    beer = Beer.create :style => "Lager"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "isn't saved without a style" do
    beer = Beer.create :name => "Brooklyn"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
