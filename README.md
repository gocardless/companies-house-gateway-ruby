# Companies House XML Gateway Ruby Client Library

Simple Ruby Gem for interacting with the Companies House XML Gateway API. Wraps
the XML submissions and responses required so you can deal with Ruby hashes
instead.

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
  config[:sender_id]        = YOUR_SENDER_ID
  config[:password]         = YOUR_PASSWORD
end
```