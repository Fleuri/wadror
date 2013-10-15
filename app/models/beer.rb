class Beer < ActiveRecord::Base

  attr_accessible :brewery_id, :name, :style

  validates :name, :presence => true
  validates :style, :presence => true

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

  def self.top(n)

    beers_with_avg_rating = []
    Brewery.all.each do |b|
      if b.average_rating(b.ratings) > 0
        beers_with_avg_rating.push(b)
      end
    end

    sorted_by_rating_in_desc_order = beers_with_avg_rating.sort_by{ |b| -b.average_rating(b.ratings) }.first(n)

  end

  def to_s
    return self.name + ": " + self.brewery.name
  end
end


