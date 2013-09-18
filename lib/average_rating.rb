module AverageRating
  def average_rating(ratings)
    @ratings = ratings
    return (@ratings.inject(0.0) { |result, rating | result + rating.score }) / @ratings.size
  end

end