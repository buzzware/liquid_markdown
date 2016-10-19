module LiquidMarkdown
  require 'kramdown'
  require 'liquid'
  require 'action_view'
  require 'action_mailer'

  require 'liquid_markdown/core_ext/hash/keys'
  require 'liquid_markdown/core_ext/string/strip'
  require 'liquid_markdown/filters/text_filter'
  require 'liquid_markdown/converter/plain_text'

  require 'liquid_markdown/version'
  require 'liquid_markdown/template_handler'
  require 'liquid_markdown/render'
end

ActionView::Template.register_template_handler :liqmd, LiquidMarkdown::TemplateHandler::LIQMD
Liquid::Template.register_filter(TextFilter)