class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score

  belongs_to :beer
  belongs_to :user

  scope :recent, order("created_at ASC").limit(5)

  validates_numericality_of :score, { :greater_than_or_equal_to => 1,
                                      :less_than_or_equal_to => 50,
                                      :only_integer => true }

  def to_s
    return self.beer.name + ": " + self.score.to_s
  end

  def self.best_styles
    style_ratings = Rating.group_by { |rating| rating.beer.style}
    style_rating = style_ratings.each_pair{|style, score| style_ratings[style] = score.sum(&:score) / score.size}
    return style_ratings.sort_by{ |style, score| score}.limit(3)
  end
end
