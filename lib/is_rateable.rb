require "is_rateable/engine"
require "is_rateable/version"

module IsRateable
  extend ActiveSupport::Autoload

  autoload :ActsAsRateable,'is_rateable/acts_as_rateable'
  autoload :ActsAsRater, 'is_rateable/acts_as_rater'

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
