class Brewery < ActiveRecord::Base
  attr_accessible :name, :year

  include AverageRating
  has_many :beers
  has_many :ratings, :through => :beers

=begin
  def average_ratings
    @ratings = self.ratings
    return (self.ratings.inject(0.0) { |result, rating | result + rating.score }) / self.ratings.size
  end
=end
end
