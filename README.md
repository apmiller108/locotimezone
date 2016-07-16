# Locotimezone

Transform a street address into geoloction and timezone data. Essentially, this
is an adapter for the [Google Maps Time Zone API](https://developers.google.com/maps/documentation/timezone/intro) and the [The Google Maps Geolocation API](https://developers.google.com/maps/documentation/geolocation/intro).

All requests to the Google APIs are done over SSL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'locotimezone'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install locotimezone

## Usage

```ruby
require 'locotimezone'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/apmiller108/locotimezone.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

