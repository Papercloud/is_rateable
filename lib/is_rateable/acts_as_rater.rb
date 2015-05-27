module IsRateable
  module ActsAsRater
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_rater(options = {})
        include IsRateable::ActsAsRater::LocalInstanceMethods

        has_many :rated_ratings, as: :rater, class_name: 'IsRateable::Rating'
      end
    end

    module LocalInstanceMethods

      # Has this object rated anything yet?
      def rated_any?
        rated_ratings.any?
      end

      # Return the objects rating for another object
      def rating_for(ratee)
        return nil unless rated_ratings.where(ratee: ratee).first
        ((rated_ratings.where(ratee: ratee).average(:score) * 10).round / 10.0)
      end
    end
  end
end
