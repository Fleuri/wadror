class Beer < ActiveRecord::Base

  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings

  def average_rating
    @ratings = Rating.find_all_by_beer_id(self.id)
  return (self.ratings.inject(0.0) { |result, rating | result + rating.score }) / self.ratings.size

    end
end


