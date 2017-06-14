# [fit] liquid_markdown gem 
## by Buzzware
<br>
##simple, logical, customer-editable templates for pages and emails

---
# liquid_markdown solves all these problems at once :
 
1) HTML gives customers too much control, they make a mess and can create security risks eg. script tags  
2) Customer editable templates need {{merge fields}} and perhaps some basic logic eg. if/then & loops but we can't let them insert arbitrary code (so no erb)
3) Editable templates means templates in the database, but sometimes you also want them in the file system too
 
---
# liquid_markdown solves all these problems at once (cont.) :
4) We want to do all this for pages and emails (rendered the same in Rails by ActionView)
5) We want to generate the text and html parts of an email with a single template
6) We want a html layout for inserting css, javascript, header tags etc for a non-html template despite Rails restriction on this

---
# Dependencies

1. liquid gem for {{templating}}

2. kramdown gem for \*\*markdown\*\*

3. panoramic gem for database templates

---
# Liquid gem solves the customer facing template problem

1. Developed by Shopify.com, one of the oldest and most successful Rails sites
2. We can trust them for keeping customers from executing arbitray code on the server
3. merge fields, loops, conditionals, filters eg. strip_html_tags
4. Works with any text

---
# Kramdown gem provides Markdown, and some important extras
1. HTML class support for styling
2. Tables
3. PlainText converter (markdown can look a bit funky)
4. "probably the fastest pure-Ruby Markdown converter available"

---
# Panoramic gem enables templates stored in the database
1. Implemented using Rails ActionView::Resolver
2. Can still use file-based templates eg. for development
3. Supports both database-first and file-first when loading
4. An optional integration, not a hard dependency

---
# Markdown is awesome for emails!
1. text and html parts of an email from a single template
2. raw markdown is almost good enough for the text part (we use Kramdown's PlainText converter to clean it up)	
3. HTML part is rendered from Markdown
4. Unlike other markdown email gems, we support HTML layouts
5. Works with Zurb Foundation for Emails (formerly Ink)

---
# Crafting Rails 4 Applications

![inline 60%](https://imagery.pragprog.com/products/353/jvrails2.jpg?1368826914)

... for Detail on Rails ActionView::Resolver

---
# Thankyou to the gem authors

* https://github.com/buzzware/liquid_markdown 
* https://rubygems.org/gems/liquid_markdown


## Happy to give access and credit for any contributions in documentation, features, fixes, examples

This presentation was written in markdown and is in the github repo above. It was rendered and played by Deskset for Mac.