class User < ActiveRecord::Base

  attr_accessible :username, :password, :password_confirmation
  has_secure_password

  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4
  validates_length_of :username, :minimum => 3, :maximum => 15
  validates_format_of :password, :with => /\A(.*[^a-z].*)\Z/i, :on => :create

  include AverageRating

  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  has_many :memberships, :dependent => :destroy
  has_many :beer_clubs, :through => :memberships

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    group_ratings = ratings.group_by { |rating| rating.beer.style}.
    return group_ratings.max_by {|key, value| average_rating(value)}.first
  end

end
