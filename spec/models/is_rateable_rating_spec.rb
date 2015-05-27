require 'spec_helper.rb'

describe IsRateable::Rating, type: :model do
  describe 'Associations' do
    before :each do
      @user = User.create(name: 'Big Al')
      @movie = Movie.create(title: "Toy Story")
      @rating = IsRateable::Rating.create(score: 1, rater: @user, ratee: @movie)
    end

    it 'belongs to a rater' do
      expect(@user.rated_ratings.first).to eq @rating
    end

    it 'belongs to a ratee' do
      expect(@movie.ratee_ratings.first).to eq @rating
    end
  end

  describe 'Validations' do
    before do
      @rating = IsRateable::Rating.create(score: 1, ratee: Movie.create(title: 'The Incredibles'), rater: User.create(name: "Violet"))
    end

    it 'is invalid without a rater' do
      @rating.rater = nil
      expect(@rating).to_not be_valid
    end

    it 'is invalid without a ratee' do
      @rating.ratee = nil
      expect(@rating).to_not be_valid
    end

    it 'is invalid without a score' do
      @rating.score = nil
      expect(@rating).to_not be_valid
    end
  end
end
