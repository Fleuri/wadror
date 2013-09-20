class User < ActiveRecord::Base
  attr_accessible :username

  include AverageRating

  has_many :ratings
  has_many :beers, :through => :ratings
  has_many :memberships
  has_many :beer_clubs, :through => :memberships

end
