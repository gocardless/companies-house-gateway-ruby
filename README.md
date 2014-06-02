# Companies House Gateway

Simple Ruby Gem for interacting with the Companies House XML Gateway API. Wraps
the XML submissions and responses required so you can deal with Ruby hashes
instead.

[![Gem Version](https://badge.fury.io/rb/companies-house-gateway.svg)](http://badge.fury.io/rb/companies-house-gateway)
[![Build Status](https://travis-ci.org/gocardless/companies-house-gateway-ruby.svg?branch=master)](https://travis-ci.org/gocardless/companies-house-gateway-ruby)

## Usage

### Installation

You don't need this source code unless you want to modify the gem. If you just
want to use it, you should run:

```ruby
gem install companies_house_gateway
````

### Initialising the gem
Requires your Companies House XML Gateway credentials. If you don't have any,
you'll need to get in touch with
[Companies House](http://xmlgw.companieshouse.gov.uk/).

```ruby
CompaniesHouseGateway.configure do |config|
  config[:sender_id] = YOUR_SENDER_ID
  config[:password]  = YOUR_PASSWORD
  config[:email]     = YOUR_EMAIL              # Optional
end
```

### Performing checks
Each check type has a convenience method on the top-level module:

```ruby
CompaniesHouseGateway.name_search(company_name: "GoCardless")
CompaniesHouseGateway.company_details(company_number: "07495895")
```

The library will raise an error if you're missing any of the required
parameters, or including any which can't be used.

### Parsing responses

Unless you've set the "raw" argument to true in your config, checks return a
hash.

```ruby
CompaniesHouseGateway.name_search(...)         # => Hash of results
```

Set the "raw" argument to true if you need the full, unprocessed response
(including headers, etc.).

```ruby
CompaniesHouseGateway.config[:raw] = true
CompaniesHouseGateway.name_search(...)         # => Faraday::Response object
```

### Caching

If you'd like to cache your requests, you can configure the gem:

```ruby
CompaniesHouseGateway.config[:cache] = Rails.cache
CompaniesHouseGateway.config[:cache_args] = { expires_in: 10.minutes }
```
