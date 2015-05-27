require "is_rateable/engine"
require "is_rateable/version"

module IsRateable
  extend ActiveSupport::Autoload

  autoload :ActsAsRateable,'is_rateable/acts_as_rateable'
  autoload :ActsAsRater, 'is_rateable/acts_as_rater'

  # Method retrieve the default rating:
  mattr_accessor :default_rating
  @@default_rating = nil

  # Method to retrieve minimum ratings before we show the average:
  mattr_accessor :minimum_ratings_for_average
  @@minimum_ratings_for_average = nil

  # Default way to setup IsRateable:
  def self.setup
    yield self
  end
end

module ActiveRecord
  class Base
    include IsRateable::ActsAsRateable
    include IsRateable::ActsAsRater
  end
end
