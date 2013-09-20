class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score

  belongs_to :beer
  belongs_to :user

  def to_s
    return self.beer.name + ": " + self.score.to_s
  end
end
