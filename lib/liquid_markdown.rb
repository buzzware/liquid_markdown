module LiquidMarkdown
  require 'liquid_markdown/version'
  require 'kramdown'
  require 'liquid'
  require 'action_view'
  require 'action_mailer'
  require 'liquid_markdown/render'
  require 'liquid_markdown/strip'
  require 'liquid_markdown/keys'
  require 'liquid_markdown/template_handler'
end

ActionView::Template.register_template_handler :liqmd, LiquidMarkdown::TemplateHandler