module IsRateable
  module ActsAsRateable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_rateable(options = {})
        include IsRateable::ActsAsRateable::LocalInstanceMethods

        has_many :ratee_ratings, as: :ratee, class_name: 'IsRateable::Rating'

        def above_average_rating(rating)
          joins(:ratee_ratings).merge(Rating.group(:ratee_id, :ratee_type).having('AVG(score) > ?', rating))
        end
      end
    end

    module LocalInstanceMethods
      # Find the Average rating for the ratee.
      # Return 0.0 if they have not been rated yet.
      def average_rating
        return IsRateable.default_rating unless enough_ratings_for_average?
        any_ratings? ? ((ratee_ratings.average(:score) * 10).round / 10.0) : 0.0
      end

      # Has this object been rated before?
      def any_ratings?
        ratee_ratings.any?
      end

      # Has the object received enough ratings to show the average?
      def enough_ratings_for_average?
        any_ratings? && ratee_ratings.length > IsRateable.minimum_ratings_for_average
      end

      # Easily add a new rating to the object by calling Object.add_rating(score: 5, rater: user)
      # Pass in the entire rater object in, rather than the id.
      def add_rating(options = {})
        Rating.create(score: options[:score], rater: options[:rater], ratee: self)
      end
    end
  end
end
