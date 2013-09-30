require 'spec_helper'
include OwnTestHelper



describe "Rating" do

  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in 'Pekka', 'foobar1'
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating(beer1.ratings)).to eq(15.0)
  end

  describe "when ratings exist" do

    before :each do
    FactoryGirl.create(:rating, :beer => beer1, :user => user)
    FactoryGirl.create(:rating2, :beer => beer2, :user => user)
      visit ratings_path
    end

    it "lists ratings on ratings page"  do
    expect(page).to have_content beer1.name
    expect(page).to have_content beer2.name
    end

    it "lists correct ratings on user's page" do
             visit user_path(user)
             expect(page).to have_content beer1.name
             expect(page).to have_content beer2.name
    end

    it "has favourite beer, style and brewery listed on user's page" do
      visit user_path(user)
      expect(page).to have_content 'style'
      expect(page).to have_content 'beer'
      expect(page).to have_content 'brewery'
    end
  end

  it "deletes a rating correctly" do
    FactoryGirl.create(:rating2, :beer => beer2, :user => user)
    visit user_path(user)
    click_link "Delete"
    expect(user.ratings.count).to eq(0)

  end
end