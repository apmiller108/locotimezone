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

Not interested in timezone? Skip it to just get geocoded results.

```ruby
require 'locotimezone'

Locotimezone.locotime address: address, skip: :timezone
# =>
# {:geo=>
#   {:formatted_address=>"525 NW 1st Ave, Fort Lauderdale, FL 33301, USA",
#      :location=>{:lat=>26.1288238, :lng=>-80.1449743}}}
```

If you alredy have latitude and longitude, and you're only interested in getting
the timezone data, just pass your own location hash like so:

```ruby
location = { lat: 26.1288238, lng: -80.1449743 }

Locotimezone.locotime location: location
# =>
# {:timezone=>
#   {:timezone_id=>"America/New_York", :timezone_name=>"Eastern Daylight Time"}}
```

If the address or location cannot be resolved, an empty hash will be returned.

```ruby
Locotimezone.locotime address: '1234 Fake Address'
# => 
# {:geo=>{}, :timezone=>{}}

Locotimezone.locotime address: '1234 Fake Address', skip: :timezone
# => 
# {:geo=>{}}

Locotimezone.locotime location: { lat: 0, lng: 0 }
# => 
# {:timezone=>{}}
```

## Options and Setup

`Locotimezone.locotime` can take the following option hash keys:
* `:address` is a string representation of a street address. This is required except when `timezone_only: true`.
* `:location` is a hash containing the latitude and longitude: `{ lat: 26.1288238, lng: -80.1449743 }`. When passing a location hash, the call to Google Maps Geolocation API is skipped.
* `:key` is for your Google API key.  This is not required but recommended if you
  want higher API quota. Create an API key and enable APIs in your [Google
  Developer Console](https://console.developers.google.com). As an alternative
  to passing the `:key` everytime, simply set `GOOGLE_API_KEY` environment variable.
* `skip: :timezone` skips the call to Google Maps Timezone API. For geolocation,
  only.

## Command Line Utility

Use the command-line utility to convert an address.

```shell
$ locotimezone 525 NW 1st Ave Fort Lauderdale, FL 33301
{:geo=>{:formatted_address=>"150 NW 1st Ave, Fort Lauderdale, FL 33301, USA", :location=>{:lat=>26.1222723, :lng=>-80.1445756}}, :timezone=>{:timezone_id=>"America/New_York", :timezone_name=>"Eastern Daylight Time"}}
```

Use the command-line utility to get timezone data for latitude and longitude

```shell
$ locotimezone -l 26.1288238,-80.1449743
{:timezone=>{:timezone_id=>"America/New_York", :timezone_name=>"Eastern Daylight Time"}}
```

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

