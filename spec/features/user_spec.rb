require 'spec_helper'
include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can sign in with right credentials" do
      sign_in 'Pekka', 'foobar1'

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
  end

  it "is redirected back to sign in form if wrong credentials given" do
    sign_in 'Pekka', 'wrong'
    expect(current_path).to eq(signin_path)
    expect(page).to have_content 'username and password do not match'
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', :with => 'Brian')
    fill_in('user_password', :with => 'secret55')
    fill_in('user_password_confirmation', :with => 'secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "can add a new beer" do
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896

    @breweries.each do |brewery|
      FactoryGirl.create(:brewery, :name => brewery, :year => year += 1)
    end

    sign_in 'Pekka', 'foobar1'
    visit new_beer_path
    select("Koff", :from => 'beer[brewery_id]')
    fill_in('beer[name]', :with => "Kalia" )
    click_button('Create Beer')
    expect(Beer.count).to eq(1)
  end


end
