require 'spec_helper'

describe IsRateable do
  it 'has a version number' do
    expect(IsRateable::VERSION).not_to be nil
  end

  describe 'acts_as_rateable' do
    before :each do
      @user = User.create(name: 'The Great Danton')
      @movie = Movie.create(title: 'The Prestige')
    end

    it 'calculates if any ratings have been made' do
      expect(@movie.any_ratings?).to eq false
    end

    it 'returns 0.0 as the average rating if it has not been rated' do
      expect(@movie.average_rating).to eq 0.0
    end

    it 'works out the average rating based on all ratings' do
      rating1 = IsRateable::Rating.create(rater: @user, ratee: @movie, score: 5)
      rating1 = IsRateable::Rating.create(rater: @user, ratee: @movie, score: 0)
      expect(@movie.average_rating).to eq 2.5
    end

    it 'adds a rating to the ratee' do
      expect{
        @movie.add_rating(score: 5, rater: @user)
      }.to change(IsRateable::Rating, :count).by(1)
    end
  end

  describe 'acts_as_rater' do
    before :each do
      @user = User.create(name: 'The Great Danton')
      @movie = Movie.create(title: 'The Prestige')
    end

    it 'calculates if the rater has rated anything' do
      expect(@user.rated_any?).to eq false
    end

    it 'returns nil if you ask for the rating of an object the rater has not rated' do
      expect(@user.rating_for(@movie)).to eq nil
    end

    it 'shows the rating that the rater added for an item' do
      rating = IsRateable::Rating.create(rater: @user, ratee: @movie, score: 5)
      expect(@user.rating_for(@movie)).to eq 5.0
    end

    it 'shows the average rating if the rater has rated an object multiple times' do
      rating = IsRateable::Rating.create(rater: @user, ratee: @movie, score: 2)
      rating = IsRateable::Rating.create(rater: @user, ratee: @movie, score: 4)

      expect(@user.rating_for(@movie)).to eq 3.0
    end
  end
end
