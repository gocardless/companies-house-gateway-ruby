require File.expand_path('../lib/companies_house_gateway/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'faraday_middleware',  '>= 0.8.2', '< 0.10'
  gem.add_runtime_dependency 'multi_xml',           '~> 0.5.1'
  gem.add_runtime_dependency 'nokogiri',            '~> 1.4'

  gem.add_development_dependency 'rspec',           '~> 3.0'
  gem.add_development_dependency 'webmock',         '~> 3.12'

  gem.authors = ['Grey Baker']
  gem.description = %q{Ruby wrapper for the Companies House XML Gateway}
  gem.email = ['grey@gocardless.com']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/gocardless/companies-house-gateway-ruby'
  gem.name = 'companies-house-gateway'
  gem.require_paths = ['lib']
  gem.summary = %q{Ruby wrapper for the Companies House XML Gateway}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = CompaniesHouseGateway::VERSION.dup
end
