![image](https://user-images.githubusercontent.com/1224077/118908609-53d82e00-b954-11eb-8392-91411d4de5e6.png)

# Paylocity Ruby Gem

Ruby toolkit for paylocity.com API.

## REST APIs and documentation
 
[Paylocity Web Service API Documentation](https://docs.paylocity.com/weblink/guides/Paylocity_Web_Services_API/Paylocity_Web_Services_API.htm#section/Overview)
 
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paylocity-ruby-gem'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install paylocity_web_service

## Config the gem

```ruby
# config/initializers/paylocity.rb
public_key = <<HEREDOC
-----BEGIN PUBLIC KEY-----
your public key
-----END PUBLIC KEY-----
HEREDOC


PaylocityWebService.configure do |config|
  config.client_id = 'your_client_id'
  config.client_secret = 'your_client_secret' 
  config.public_key = public_key
end
```

## Making requests

```ruby
# Provide authentication credentials
client = PaylocityWebService::Client.new(company_id: 'S2222')

# retrieve all employees
client.employees

# get the employee by id
client.employee(1)

# create the employee
client.create_employee(options={})

# get the open api document of current company.
client.company_schema
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/helloworld1812/paylocity-ruby-gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

Here are some ways you can contribute:

- by reporting bugs
- by suggesting new features
- by writing or editing documentation
- by writing test case
- by writing code (no patch is too small: fix typos, add comments, clean up inconsistent whitespace)
- by refactoring code
- by closing issues
- by reviewing patches

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project’s codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/wotc-ruby-gem/blob/master/CODE_OF_CONDUCT.md).

## Reference

**Good examples of API Wrapper**

- [Octokit](https://github.com/octokit/octokit.rb/blob/master/lib/octokit/client.rb)
- [Instagram](https://github.com/Instagram/instagram-ruby-gem/blob/master/lib/instagram/client.rb)
- [Twitter](https://github.com/sferik/twitter/blob/master/lib/twitter/rest/api.rb)

