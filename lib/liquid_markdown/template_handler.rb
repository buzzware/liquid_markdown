module LiquidMarkdown
  module TemplateHandler
    def self.erb_handler
      @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def self.call(template)
      compiled_source = erb_handler.call(template)
      "begin;#{compiled_source};end)"
    end
  end
end