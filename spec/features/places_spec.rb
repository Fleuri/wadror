require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([Place.new(:name => "Oljenkorsi", :id => 1)])

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"


    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one is returned, they are both shown on page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([Place.new(:name => "Oljenkorsi", :id => 1), Place.new(:name => "Gurula", :id => 2)])

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"


    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Gurula"
  end

  it "if none is returned 'no locations in <place>' is shown" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([])

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end

