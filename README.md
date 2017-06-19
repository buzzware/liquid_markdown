[![Gem Version](https://badge.fury.io/rb/liquid_markdown.svg)](https://badge.fury.io/rb/liquid_markdown)

# LiquidMarkdown

Combines [Liquid](https://github.com/Shopify/liquid) and [Markdown](https://daringfireball.net/projects/markdown/) templating
for generic templating and Rails Mailers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liquid_markdown', '~> 0.2.1'
# If you want to use database template
gem 'panoramic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquid_markdown

## Usage

You can use `liquid_markdown` in your mailer with `.liqmd` file extension

### Using Rails mailer and view template

```ruby
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    @lmVariables = @user.values

    mail(to: @user.email, subject: 'liquid markdown layout') do |format|
        format.html
        format.text
    end
  end
end
```

```html
# app/views/user_mailer/welcome.liqmd

# Hello Admin

Below are the list of products that you purchased

<ul id="products">
    <li>
        <h2>{{ product.name }}</h2>
        Only {{ product.price | price }}
    </li>
</ul>

Thanks
------
ABC XYZ
```

### Using `panoramic` for database template

Please read full documentation in [Panoramic](https://github.com/andreapavoni/panoramic/blob/master/README.md)

* Add following line to your `Gemfile`

```
gem 'panoramic'
```

* Your model should have the following fields: `body:text`, `path:string`,
`locale:string`, `handler:string`, `partial:boolean`, `format:string`

* Add below line to your Model

```ruby
class TemplateStorage < ActiveRecord::Base
  store_templates

  # required lines for liquid_markdown
  def self.resolver(options={})
    LiquidMarkdown::Resolver.using self, options
  end
end
```

Now you can use `liqmd` handler in your `TemplateStorage`

```ruby
TemplateStorage.create(
  body: "# Hello {{user.email}}, \n\n You have successfully subscribed to our
  daily newsletter.",
  path: 'user_mailer/confirmation',
  handler: 'liqmd',
  format: 'html'
)
```

* Now you can use `resolver` in your mailer

```ruby
class UserMailer < ActionMailer::Base
  prepend_view_path TemplateStorage.resolver

  def confirmation(user)
    @user = user

    mail(
      from: "someone@example.com",
      to: @user.email,
      subject: "Confirmation Link",
      template_name: @user.template_name
    )
  end
end
```

We can compile Liquid templates manually using `html` to convert into html format and `text` to convert into plain text.

```ruby
lm = LiquidMarkdown::Render.new("Hello {{user.profile.name}}!", {user: {profile: {name: 'Bob'}}})
lm.html # => "<p>Hello Bob!</p>"
lm.text # => "Hello Bob!"
```

```ruby
lm = LiquidMarkdown::Render.new("# my first heading") 
lm.html # => "<h1>my first heading</h1>"
lm.text # => "my first heading"
```

We can combine both Liquid and Markdown together, Liquid will get compiled first and then Markdown will get compiled

```ruby
lm = LiquidMarkdown::Render.new("# Hello {{username | upcase}}", {username: 'Admin'})
lm.html # => "<h1>Hello ADMIN</h1>"
lm.text # => "Hello ADMIN"
```

## Depricated (need to remove this)
We can also setup layout options to wrap result within that layout. use `{{yield}}` block in your template where we can render output.

```ruby
lm = LiquidMarkdown::Render.new("# Hello {{username | upcase}}", {username: 'Admin'})
lm.layout = "<html><head></head><body>{{yield}}</body></html>"
lm.html # => "<html><head></head><body><h1>Hello ADMIN</h1></body></html>"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buzzware/liquid_markdown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

