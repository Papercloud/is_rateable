# IsRateable

### Easily drop a rating system into your Rails project. 

IsRateable allows any object to be rateable by any other object with very little setup. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'is_rateable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install is_rateable

## Getting Started

### Adding the ratings table and initializer.

    $ rails generate is_rateable:install
    $ rake db:migrate 

**If you are using UUIDS:** 

    $ rails generate is_rateable:install --id_column_type uuid
    $ rake db:migrate 

This makes sure that the references to your `rater` and `ratee` uses a `:uuid` column rather than an `:integer` one

### Configuring the initializer

in `config/initializers/is_rateable.rb`:

`minimum_ratings_for_average` sets the amount of ratings an object must have before the average is calculated. This stops the ratings swaying wildly when an object is new.

`default_rating` sets the rating that is returned if the object does not have enough ratings for the average, and you ask for it's `average_rating`

### Configuring your models

For the object that you wish to be rateable:

```ruby 
class MyModel < ActiveRecord::Base
  acts_as_rateable

  # your code here...
end
```

For the object you wish to be able to submit ratings:

```ruby
class MyModel < ActiveRecord::Base
  acts_as_rater

  # your code here...
end
```

This will give you access to all the methods describe below.

## Usage

### Adding a new rating

The `Rating` is created from the object that `acts_as_rateable`. It takes 2 options:

* `rater:` The object setting the rating.
* `score:` The score of the rating.

As an example lets say that we have a `Movie` model, that can be rated by `Users`.

```ruby
@user = User.first
@movie = Movie.find_by(name: 'Toy Story 2')

@movie.add_rating(score: 5, rater: user)
```

**NOTE:** The `add_rating` method expects the object of the rater to be passed in, not just the `id`.

### Viewing Ratings

**All ratings that have been added to the object:**

Ratings applied to an object are called `ratee_ratings`

```ruby 
@movie.ratee_ratings
=> ActiveRecord::Association: []
```

**Average rating of an object:**

This shows the average of all ratings applied to an object. Rounded to the nearest `0.1`

```ruby 
@movie.average_rating
=> 4.8
```

**Has the object been rated at all?:**

```ruby
@movie.any_ratings?
=> true
```

### Viewing Raters

**Has the object rated anything?:**

```ruby
@user.rated_any?
=> true
```

**All Ratings that an object as given to another object:**

Ratings that an object has applied to another object are stored as `rated_ratings`.

```ruby
@user.rated_ratings
=> ActiveRecord::Association: []
```

**Rating that a rater has given to a particular object:**

If the object has rated something more than once, then it will return the average rating they have provided for that object (eg. Uber if you have had the same driver multiple times).

```ruby
@user.rating_for(@movie)
=> 5.0
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/Papercloud/is_rateable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
