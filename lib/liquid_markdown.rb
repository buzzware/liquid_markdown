module LiquidMarkdown
  require 'liquid_markdown/version'
  require 'kramdown'
  require 'liquid'
  require 'action_view'
  require 'action_mailer'
  require 'liquid_markdown/strip'
  require 'liquid_markdown/keys'
  require 'liquid_markdown/template_handler'
  require 'liquid_markdown/resolver'
end

ActionMailer::Base.prepend_view_path(LiquidMarkdown::Resolver.new)
ActionView::Template.register_template_handler(:liqmd, LiquidMarkdown::TemplateHandler::HTML)
ActionView::Template.register_template_handler(:liqmdt, LiquidMarkdown::TemplateHandler::Text)