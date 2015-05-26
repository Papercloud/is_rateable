module IsRateable
  class Rating < ActiveRecord::Base
    # Associations
    belongs_to :rater, polymorphic: true
    belongs_to :ratee, polymorphic: true

    # Validations
    validates :rater, presence: true
    validates :ratee, presence: true
    validates :score, presence: true
  end
end
