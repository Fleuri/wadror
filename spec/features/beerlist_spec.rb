require 'spec_helper'

describe "Beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(:allow_localhost => true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    @brewery1 = FactoryGirl.create(:brewery)
    @brewery2 = FactoryGirl.create(:brewery2)
    @beer1 = FactoryGirl.create(:beer)
    @beer2 = FactoryGirl.create(:beer2)
  @brewery1.beers << @beer1
    @brewery2.beers << @beer2
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", :js =>true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "anonymous"
  end

  it "shows beer in right order", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)').should have_content("anonymous")
    find('table').find('tr:nth-child(3)').should have_content("Cola")

  end

  it "shows beer in right order after style click", :js => true do
    visit beerlist_path
    click_link("Style")
    find('table').find('tr:nth-child(2)').should have_content("anonymous")
    find('table').find('tr:nth-child(3)').should have_content("Cola")

  end

  it "shows beer in right order after brewery click", :js => true do
    visit beerlist_path
    click_link("Brewery")
    find('table').find('tr:nth-child(2)').should have_content("anonymous")
    find('table').find('tr:nth-child(3)').should have_content("Cola")

  end
end