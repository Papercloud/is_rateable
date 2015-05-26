module IsRateable
  module ActsAsRateable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_rateable(options = {})
        include IsRateable::ActsAsRateable::LocalInstanceMethods

        has_many :ratee_ratings, as: :ratee, class_name: 'IsRateable::Rating'
      end
    end

    module LocalInstanceMethods
      # Find the Average rating for the ratee.
      # Return 0.0 if they have not been rated yet.
      def average_rating
        any_ratings? ? ((ratee_ratings.average(:score) * 10).round / 10.0) : 0.0
      end

      # Has this object been rated before?
      def any_ratings?
        ratee_ratings.any?
      end

      # Easily add a new rating to the object by calling Object.add_rating(score: 5, rater: user)
      # Pass in the entire rater object in, rather than the id.
      def add_rating(options = {})
        Rating.create(score: options[:score], rater: options[:rater], ratee: self)
      end
    end
  end
end
