[![Code Triagers Badge](https://www.codetriage.com/apmiller108/locotimezone/badges/users.svg)](https://www.codetriage.com/apmiller108/locotimezone)

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
Geolocate and get timezone details:

```ruby
require 'locotimezone'

address = '525 NW 1st Ave Fort Lauderdale, FL 33301'

Locotimezone.locotime address: address
# =>
# {:geo=>
#   {:formatted_address=>"525 NW 1st Ave, Fort Lauderdale, FL 33301, USA",
#      :location=>{:lat=>26.1288238, :lng=>-80.1449743}},
#  :timezone=>
#   {:timezone_id=>"America/New_York", :timezone_name=>"Eastern Daylight Time"}}
```

Not interested in timezone? Skip it. 

```ruby
require 'locotimezone'

Locotimezone.locotime address: address, location_only: true
# =>
# {:geo=>
#   {:formatted_address=>"525 NW 1st Ave, Fort Lauderdale, FL 33301, USA",
#      :location=>{:lat=>26.1288238, :lng=>-80.1449743}}}
```

Only want timezone? No problem, but you'll need include a location hash.

```ruby
location = { lat: 26.1288238, lng: -80.1449743 }

Locotimezone.locotime location: location, timezone_only: true
# =>
# {:timezone=>
#   {:timezone_id=>"America/New_York", :timezone_name=>"Eastern Daylight Time"}}
```

If the address or location cannot be resolved, an empty hash will be returned.

```ruby
Locotimezone.locotime address: '1234 Fake Address'
# => 
# {:geo=>{}, :timezone=>{}}
```

## Options and Setup

`Locotimezone.locotime` can take the following option hash keys:
* `:address` is a string representation of a street address. This is required except when `timezone_only: true`.
* `:location` is required only when `timezone_only: true`. The corresponding
  value is a hash containing the latitude and longitude: `{ lat: 26.1288238, lng: -80.1449743 }`.
* `:key` is for your Google API key.  This is not required but recommended if you
  want higher API quota. Create an API key and enable APIs in your [Google
  Developer Console](https://console.developers.google.com). As an alternative
  to passing the `:key` everytime, simply set `GOOGLE_API_KEY` environment variable.
* `location_only: true` skips the call to Google Maps Timezone API. Geolocation only.
* `timezone_only: true` skips the call to Google Maps Geolocation API.  Gets only the
  timezone data for the specified `:location`.  When `timezone_only: true`, you
  must inlcude the `:location` hash (see above).

## Versions of Ruby

This library should work with Ruby 2.1 and higher versions.

It has been tested on the following versions of Ruby:
* Ruby 2.3

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/apmiller108/locotimezone.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

