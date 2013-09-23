class Beer < ActiveRecord::Base

  attr_accessible :brewery_id, :name, :style

  validates :name, :presence => true

  include AverageRating
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :users

=begin
  def average_rating
    @ratings = Rating.find_all_by_beer_id(self.id)
  return (self.ratings.inject(0.0) { |result, rating | result + rating.score }) / self.ratings.size

  end
=end

  def to_s
    return self.name + ": " + self.brewery.name
  end
end


