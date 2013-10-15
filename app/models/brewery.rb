class Brewery < ActiveRecord::Base
  attr_accessible :name, :year, :active

  scope :active, where(:active => true)
  scope :retired, where(:active => [nil, false])

  include AverageRating
  has_many :beers
  has_many :ratings, :through => :beers

  validates :name, :presence => true
  validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
                                      :only_integer => true }
  validate :not_in_future


  def not_in_future
    if year.presence && year > Time.now.year
      errors.add(:year, "can't be in the future")
    end
    end
=begin

  def average_ratings
    @ratings = self.ratings
    return (self.ratings.inject(0.0) { |result, rating | result + rating.score }) / self.ratings.size
  end
=end

  def self.top(n)

    breweries_with_avg_rating = []
    Brewery.all.each do |b|
      if b.average_rating(b.ratings) > 0
        breweries_with_avg_rating.push(b)
      end
    end

    sorted_by_rating_in_desc_order = breweries_with_avg_rating.sort_by{ |b| -b.average_rating(b.ratings) }.first(n)

  end
end

