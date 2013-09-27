require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new :username => "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a proper password" do
    user = User.create :username => "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do


      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating(user.ratings)).to eq(15.0)
    end
  end

  it "is not saved with a too short password" do
    user = User.create :username => "Pekka", :password => "jo1", :password_confirmation => "jo1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with a false password confirmation" do
    user = User.create :username => "Pekka", :password => "secret1", :password_confirmation => "secret2"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with a password consisting only of letters" do
    user =  User.create :username => "Pekka", :password => "secret", :password_confirmation => "secret"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating 10, user

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings 10, 20, 15, 7, 9, user
      best = create_beer_with_rating 25, user

      expect(user.favorite_beer).to eq(best)
    end



  end

  describe "favourite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "has no favourites without ratings" do
      expect(user.favorite_style).to eq(nil)
    end

    it "with only one rating returns the style of the associated beer" do
      beer = create_beer_with_rating(20, user)
      expect(user.favorite_style).to eq(beer.style)
    end


    it "With many ratings returns the style of associated beers with best average rating" do
      create_beers_with_ratings_and_styles([10, 5, 8, 10], ["Lager", "Lager", "Pilsner", "Pilsner"], user)
      beer = create_beer_with_rating_and_style(12, "Pilsner", user)
      expect(user.favorite_style).to eq(beer.style)
    end
  end

  def create_beers_with_ratings( *scores, user)
  scores.each do |score|
    create_beer_with_rating score, user
  end
  end

  def create_beer_with_rating(score,  user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end

  def create_beers_with_ratings_and_styles(scores, styles, user)
  if (scores.length != styles.length)
    return nil
  else
    scores.zip(styles).each do |score, style|
      create_beer_with_rating_and_style(score, style, user)
    end
  end
  end

    def create_beer_with_rating_and_style(score, style, user)
      beer = FactoryGirl.create(:beer)
      beer.style = style
      FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
      beer
    end


end


