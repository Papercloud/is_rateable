IsRateable.setup do |config|
  # Return the default raitng for ratee, when they have not received any ratings
  config.default_rating = 5.0
  # Limit the amount of ratings an object must have received before it returns the average
  config.minimum_ratings_for_average = 0
end
