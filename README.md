# LiquidMarkdown

Combines [Liquid](https://github.com/Shopify/liquid) and [Markdown](https://daringfireball.net/projects/markdown/) templating
for generic templating and Rails Mailers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liquid_markdown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquid_markdown

## Usage

We can compile Liquid templates:

```ruby
lm = LiquidMarkdown::Render.new("Hello {{user.profile.name}}!", {user: {profile: {name: 'Bob'}}})
lm.render # => "Hello Bob!"
```

We can compile Markdown templates:

```ruby
lm = LiquidMarkdown::Render.new("# my first heading") 
lm.render # => "<h1>my first heading</h1>"
```

We can combine both Liquid and Markdown together, Liquid will get compiled first and then Markdown will get compiled

```ruby
lm = LiquidMarkdown::Render.new("# Hello {{username | upcase}}", {username: 'Admin'})
lm.render # => "<h1>Hello ADMIN</h1>"
```

We can also setup layout options to wrap result within that layout. use `{{yield}}` block in your template where we can render output.

```ruby
lm = LiquidMarkdown::Render.new("# Hello {{username | upcase}}", {username: 'Admin'})
lm.layout = "<html><head></head><body>{{yield}}</body></html>"
lm.render # => "<html><head></head><body><h1>Hello ADMIN</h1></body></html>"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buzzware/liquid_markdown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

